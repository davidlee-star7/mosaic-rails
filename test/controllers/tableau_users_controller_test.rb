require 'test_helper'

class TableauUsersControllerTest < ActionController::TestCase
  setup do
    @tableau_user = tableau_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tableau_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tableau_user" do
    assert_difference('TableauUser.count') do
      post :create, tableau_user: {  }
    end

    assert_redirected_to tableau_user_path(assigns(:tableau_user))
  end

  test "should show tableau_user" do
    get :show, id: @tableau_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tableau_user
    assert_response :success
  end

  test "should update tableau_user" do
    patch :update, id: @tableau_user, tableau_user: {  }
    assert_redirected_to tableau_user_path(assigns(:tableau_user))
  end

  test "should destroy tableau_user" do
    assert_difference('TableauUser.count', -1) do
      delete :destroy, id: @tableau_user
    end

    assert_redirected_to tableau_users_path
  end
end
