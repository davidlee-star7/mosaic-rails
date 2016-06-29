require 'test_helper'

class MicrositesGroupsControllerTest < ActionController::TestCase
  setup do
    @microsites_group = microsites_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:microsites_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create microsites_group" do
    assert_difference('MicrositesGroup.count') do
      post :create, microsites_group: {  }
    end

    assert_redirected_to microsites_group_path(assigns(:microsites_group))
  end

  test "should show microsites_group" do
    get :show, id: @microsites_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @microsites_group
    assert_response :success
  end

  test "should update microsites_group" do
    patch :update, id: @microsites_group, microsites_group: {  }
    assert_redirected_to microsites_group_path(assigns(:microsites_group))
  end

  test "should destroy microsites_group" do
    assert_difference('MicrositesGroup.count', -1) do
      delete :destroy, id: @microsites_group
    end

    assert_redirected_to microsites_groups_path
  end
end
