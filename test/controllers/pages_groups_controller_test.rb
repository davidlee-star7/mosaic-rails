require 'test_helper'

class PagesGroupsControllerTest < ActionController::TestCase
  setup do
    @pages_group = pages_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pages_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pages_group" do
    assert_difference('PagesGroup.count') do
      post :create, pages_group: {  }
    end

    assert_redirected_to pages_group_path(assigns(:pages_group))
  end

  test "should show pages_group" do
    get :show, id: @pages_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pages_group
    assert_response :success
  end

  test "should update pages_group" do
    patch :update, id: @pages_group, pages_group: {  }
    assert_redirected_to pages_group_path(assigns(:pages_group))
  end

  test "should destroy pages_group" do
    assert_difference('PagesGroup.count', -1) do
      delete :destroy, id: @pages_group
    end

    assert_redirected_to pages_groups_path
  end
end
