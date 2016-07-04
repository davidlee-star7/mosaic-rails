require 'test_helper'

class GroupsVariablesControllerTest < ActionController::TestCase
  setup do
    @groups_variable = groups_variables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups_variables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create groups_variable" do
    assert_difference('GroupsVariable.count') do
      post :create, groups_variable: {  }
    end

    assert_redirected_to groups_variable_path(assigns(:groups_variable))
  end

  test "should show groups_variable" do
    get :show, id: @groups_variable
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @groups_variable
    assert_response :success
  end

  test "should update groups_variable" do
    patch :update, id: @groups_variable, groups_variable: {  }
    assert_redirected_to groups_variable_path(assigns(:groups_variable))
  end

  test "should destroy groups_variable" do
    assert_difference('GroupsVariable.count', -1) do
      delete :destroy, id: @groups_variable
    end

    assert_redirected_to groups_variables_path
  end
end
