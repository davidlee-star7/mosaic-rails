require 'test_helper'

class ExtraFieldsControllerTest < ActionController::TestCase
  setup do
    @extra_field = extra_fields(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:extra_fields)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create extra_field" do
    assert_difference('ExtraField.count') do
      post :create, extra_field: { cms_page_id: @extra_field.cms_page_id, field_name: @extra_field.field_name, field_setting: @extra_field.field_setting, field_value: @extra_field.field_value }
    end

    assert_redirected_to extra_field_path(assigns(:extra_field))
  end

  test "should show extra_field" do
    get :show, id: @extra_field
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @extra_field
    assert_response :success
  end

  test "should update extra_field" do
    patch :update, id: @extra_field, extra_field: { cms_page_id: @extra_field.cms_page_id, field_name: @extra_field.field_name, field_setting: @extra_field.field_setting, field_value: @extra_field.field_value }
    assert_redirected_to extra_field_path(assigns(:extra_field))
  end

  test "should destroy extra_field" do
    assert_difference('ExtraField.count', -1) do
      delete :destroy, id: @extra_field
    end

    assert_redirected_to extra_fields_path
  end
end
