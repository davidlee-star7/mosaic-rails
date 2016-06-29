require 'test_helper'

class QfieldsControllerTest < ActionController::TestCase
  setup do
    @qfield = qfields(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qfields)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qfield" do
    assert_difference('Qfield.count') do
      post :create, qfield: { fval: @qfield.fval, section_id: @qfield.section_id, type_id: @qfield.type_id }
    end

    assert_redirected_to qfield_path(assigns(:qfield))
  end

  test "should show qfield" do
    get :show, id: @qfield
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @qfield
    assert_response :success
  end

  test "should update qfield" do
    patch :update, id: @qfield, qfield: { fval: @qfield.fval, section_id: @qfield.section_id, type_id: @qfield.type_id }
    assert_redirected_to qfield_path(assigns(:qfield))
  end

  test "should destroy qfield" do
    assert_difference('Qfield.count', -1) do
      delete :destroy, id: @qfield
    end

    assert_redirected_to qfields_path
  end
end
