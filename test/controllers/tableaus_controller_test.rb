require 'test_helper'

class TableausControllerTest < ActionController::TestCase
  setup do
    @tableau = tableaus(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tableaus)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tableau" do
    assert_difference('Tableau.count') do
      post :create, tableau: { height: @tableau.height, load_order: @tableau.load_order, site_root: @tableau.site_root, tabs: @tableau.tabs, ticket: @tableau.ticket, toolbar: @tableau.toolbar, width: @tableau.width }
    end

    assert_redirected_to tableau_path(assigns(:tableau))
  end

  test "should show tableau" do
    get :show, id: @tableau
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tableau
    assert_response :success
  end

  test "should update tableau" do
    patch :update, id: @tableau, tableau: { height: @tableau.height, load_order: @tableau.load_order, site_root: @tableau.site_root, tabs: @tableau.tabs, ticket: @tableau.ticket, toolbar: @tableau.toolbar, width: @tableau.width }
    assert_redirected_to tableau_path(assigns(:tableau))
  end

  test "should destroy tableau" do
    assert_difference('Tableau.count', -1) do
      delete :destroy, id: @tableau
    end

    assert_redirected_to tableaus_path
  end
end
