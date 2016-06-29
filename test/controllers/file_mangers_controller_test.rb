require 'test_helper'

class FileMangersControllerTest < ActionController::TestCase
  setup do
    @file_manger = file_mangers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:file_mangers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create file_manger" do
    assert_difference('FileManger.count') do
      post :create, file_manger: { attachment: @file_manger.attachment, name: @file_manger.name, size: @file_manger.size }
    end

    assert_redirected_to file_manger_path(assigns(:file_manger))
  end

  test "should show file_manger" do
    get :show, id: @file_manger
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @file_manger
    assert_response :success
  end

  test "should update file_manger" do
    patch :update, id: @file_manger, file_manger: { attachment: @file_manger.attachment, name: @file_manger.name, size: @file_manger.size }
    assert_redirected_to file_manger_path(assigns(:file_manger))
  end

  test "should destroy file_manger" do
    assert_difference('FileManger.count', -1) do
      delete :destroy, id: @file_manger
    end

    assert_redirected_to file_mangers_path
  end
end
