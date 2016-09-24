class DashBoardsController < ApplicationController
  before_action :set_dash_board, only: [:show, :edit, :update, :destroy]

  # GET /dash_boards
  # GET /dash_boards.json
  def index
    @dash_boards = DashBoard.all
  end

  # GET /dash_boards/1
  # GET /dash_boards/1.json
  def show
  end

  # GET /dash_boards/new
  def new
    @dash_board = DashBoard.new
  end

  # GET /dash_boards/1/edit
  def edit
  end

  # POST /dash_boards
  # POST /dash_boards.json
  def create
    @dash_board = DashBoard.new(dash_board_params)

    respond_to do |format|
      if @dash_board.save
        format.html { redirect_to @dash_board, notice: 'Dash board was successfully created.' }
        format.json { render :show, status: :created, location: @dash_board }
      else
        format.html { render :new }
        format.json { render json: @dash_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dash_boards/1
  # PATCH/PUT /dash_boards/1.json
  def update
    respond_to do |format|
      if @dash_board.update(dash_board_params)
        format.html { redirect_to @dash_board, notice: 'Dash board was successfully updated.' }
        format.json { render :show, status: :ok, location: @dash_board }
      else
        format.html { render :edit }
        format.json { render json: @dash_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dash_boards/1
  # DELETE /dash_boards/1.json
  def destroy
    @dash_board.destroy
    respond_to do |format|
      format.html { redirect_to dash_boards_url, notice: 'Dash board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dash_board
      @dash_board = DashBoard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dash_board_params
      params.fetch(:dash_board, {})
    end
end
