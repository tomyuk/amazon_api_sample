#
#
#
class DashBoardController < ApplicationController
  # GET /dash_board
  def index
  end

  #
  def mark_access
  end

  private

  def dash_board_params
    params.fetch(:dash_board, {})
  end
end
