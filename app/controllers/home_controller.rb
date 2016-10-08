class HomeController < ApplicationController
  # before_action :set_home, only: [:show, :edit, :update, :destroy]

  # GET /homes
  # GET /homes.json
  def index
    pp view_context.active_menu("home")
    # @homes = Home.all
  end

  #
  #
  #
  def mark_access
  end
end
