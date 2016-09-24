require 'test_helper'

class DashBoardsControllerTest < ActionController::TestCase
  setup do
    @dash_board = dash_boards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dash_boards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dash_board" do
    assert_difference('DashBoard.count') do
      post :create, dash_board: {  }
    end

    assert_redirected_to dash_board_path(assigns(:dash_board))
  end

  test "should show dash_board" do
    get :show, id: @dash_board
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dash_board
    assert_response :success
  end

  test "should update dash_board" do
    patch :update, id: @dash_board, dash_board: {  }
    assert_redirected_to dash_board_path(assigns(:dash_board))
  end

  test "should destroy dash_board" do
    assert_difference('DashBoard.count', -1) do
      delete :destroy, id: @dash_board
    end

    assert_redirected_to dash_boards_path
  end
end
