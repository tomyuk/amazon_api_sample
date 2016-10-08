class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, :unless => :api?

  before_filter :authenticate_user!, :unless => [:logout?, :api?]
  before_filter :configure_permitted_parameters, :if => [:devise_controller?]
  before_filter :mark_access, :unless => [:devise_controller?, :logout?]

  helper_method :controller_fullname, :current_project, :current_media, :current_content, :current_publication

  rescue_from Exception, with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  # ログアウト状態か
  # @return [Boolean]
  def logout?
    false
  end

  # APIか?
  # @return [Boolean]
  def api?
    false
  end

  #-- Class Methods

  # コントローラーのネームスペースも含めた名前をスネークケースで返す
  # @return [String] コントローラの名前
  # @example
  #   Admin::TestDataController の場合 "admin_test_data" を返す
  def self.fullname
    @controller_fullname ||= self.name.sub(/Controller$/, '').underscore.sub('/', '_')
  end

  #-- Callbacks

  # ログイン後のパスを取得
  # @param resource []
  # @return [String]
  def after_sign_in_path_for(resource) 
    Session.cleanup
    root_url
  end

  # ログアウト後のパスを取得 TODO
  # @param resource []
  # @return [String]
  def after_sign_out_path_for(resource)
    if session[:last_user_id]
      ContentEditInfo.delete_all_lock(session[:last_user_id], session.id)
      @last_user = User.find_by(id: session[:last_user_id])
      session[:last_user_id] = nil
    end
    # session.delete(:pages_show_page_id)
    # AppLog.log_logout(self, @last_user)
    # session.delete(:current_project_id)
    '/'
  end 

  #-- Methos

  # コントローラー名取得
  #
  # @return [String]
  def controller_fullname
    self.class.fullname
  end

  # curent_medium, curent_content, current_publication を取得する
  #
  # @return [Object]
  [:current_medium, :current_content, :current_publication].each do |name|
    name = name.to_s
    ApplicationController.send :define_method, "#{name}=" do |val|
      session["#{name}_id"] = val && val.id || nil
      session["#{name}"] = nil
      instance_variable_set(:"@#{name}", val)
    end
  end

  # 現在のプロジェクトIDを取得
  #
  # @return [Integer]
  def current_project_id
    unless current_user
      return nil
    end
    if session[:current_project_id].present?
      return session[:current_project_id].to_i
    end
    # 前回選択したプロジェクトがcookieに残っている場合はそれを選択する
    last_project_id = cookies[SETTINGS.mypage.project_cookie + '_' + current_user.id.to_s]
    if last_project_id.present?
      last_prj = Project.find_by(id: last_project_id.to_i)
      if last_prj && last_prj.is_viewable_by(current_user)
        return last_prj.id
      end
    end
    # 管理者の場合最も若いIDのプロジェクトを選択する
    if current_user.admin?
      proj = Project.order(:id).first
      if proj
        return proj.id
      end
    end
    # 参加しているプロジェクトの最もIDが若いものを選択する
    id = nil
    current_user.groups.each do |g|
      # 所有グループ
      xid = g.holding_project_ids.sort[0]
      if xid
        if !id
          id = xid
        else
          id = xid if id > xid
        end
      end
    end
    if id
      return id
    end
    current_user.groups.each do |g|
      # 参加グループ
      xid = g.project_ids.sort[0]
      if xid
        if !id
          id = xid
        else
          id = xid if id > xid
        end
      end
    end
    id
  end

  # 現在のプロジェクトを取得
  #
  # @return [Project]
  def current_project
    unless current_user
      return nil
    end
    if @current_project
      @current_project
    else
      prj = nil
      prj_id = self.current_project_id
      if prj_id
        def_prj = Project.find_by(id: prj_id)
        if def_prj && def_prj.is_viewable_by(current_user)
          prj = def_prj
        end
      end
      self.current_project = prj
    end
  end

  # 現在のプロジェクトをセット
  # @param project [Project]
  # @return [Project]
  def current_project=(project)
    current_project_id = project && project.id || nil
    if current_user
      expires = SETTINGS.cookie_expires
      expires = expires.to_i / 24 / 60 / 60
      cookies[SETTINGS.mypage.project_cookie + '_' + current_user.id.to_s] = {
        value: current_project_id,
        expires: expires.days.from_now
      }
    end
    session[:current_project_id] = current_project_id
    @current_project = project
  end

  # 現在のメディアを取得
  #
  # @return [Media]
  def current_medium
    instance_variable_or_session_get(:current_medium) do |id|
      medium = nil
      if current_project
        if id
          medium = current_project.media.find_by(id: id)
        end
        unless medium
          medium = current_project.default_medium
        end
        medium
      else
        nil
      end
    end
  end

  # 現在のコンテンツを取得
  #
  # @return [Content]
  def current_content
    instance_variable_or_session_get(:current_content) do |id|
      content = nil
      if current_project
        if id
          content = Content.find_by(id: id, project: current_project)
        end
        if content
          @current_content_intrash = true if content.deleted_date
        else          
          @current_content_missing = true
          content = current_project.root_content
        end
      end
      content # XXXXX
    end
  end

  # 現在のコンテンツ公開情報を取得
  #
  # @return [ContentPublication]
  def current_publication
    instance_variable_or_session_get(:current_publication) do |id|
      publication = nil
      if current_content
        if current_content.accessible_by?(current_user) && id
          publication = ContentPublication.find_by(id: id, content: current_content)
        end
        unless publication
          publication = current_content.newest_publication_by_user(current_user)
        end
      end
      publication
    end
  end

  # SEETINGからメッセージコードでメッセージを取得する
  # @param code [String]
  # @param args [Hash]
  # @return [String]
  def msg(code, *args)
    options = args.extract_options!
    form = SETTINGS.messages[code.to_sym]
    if form
      form = form.dup
      args.each_with_index do |arg, ix|
        form.sub!("{#{ix}}", arg.to_s)
      end
      options.each do |k, v|
        form.sub!("{#{k}}", v.to_s)
      end
      form.html_safe
    else
      "(不明なメッセージ:#{code})"
    end
  end

  def ie8?
    request.env['HTTP_USER_AGENT'].is_a?(String) && request.env['HTTP_USER_AGENT'].include?('MSIE 8.0;')
  end

  protected

  #---------------------------------------
  # for devise
  
  # Check logging in
  # @return []
  def configure_permitted_parameters
    devise_parameter_sanitizer.sanitize(:sign_in) { |u| u.permit(:name, :mail_address) }
    if current_user
      @last_user = current_user.clone
    end
  end

  #
  #
  #

  private

  def log_exc(exc, message)
    # TODO: ファイルを開いて書き込む
    puts '#' * 80
    puts message
    puts exc.to_s
    puts '-' * 40
    puts exc.backtrace
    puts '#' * 80
  end

  def record_not_found
    respond_to do |format|
      format.json do
        render json: {
          status: :not_found,
          error: msg(:e_0048)
        },
        status: 404
      end
      format.html do
        flash[:error] = msg(:e_0048)
        render text: "404 Not Found", status: 404
      end
    end
  end

  def internal_server_error(e)
    if ENV['RAILS_ENV'] != 'production'
      raise e
    end
    respond_to do |format|
      format.json do
        render json: {
          status: :internal_server_error,
          error: msg(:e_0049, e.message, e.backtrace[0])
        },
        status: 500
      end
      format.html do
        flash[:error] = msg(:e_0049, e.message, e.backtrace[0])
        render text: "Internal Server Error", status: 500
      end
    end
  end

  def instance_variable_or_session_get(name)
    name = name.to_s
    unless (val = instance_variable_get(:"@#{name}"))
      val = yield session["#{name}_id"]
      if val
        session["#{name}_id"] = val.id
        instance_variable_set(:"@#{name}", val)
      end
    end
    val
  end

  def mypage?
    false
  end

  def mypage_filter
    if params[:action] == 'index'
      #
    end
  end

  def mark_access
  end

end
