module ApplicationHelper
  def active_menu(name)
    controller.controller_name == name ? 'class="active"' : ''
  end
end
