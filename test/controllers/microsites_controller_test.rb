require 'test_helper'

class MicrositesControllerTest < ActionController::TestCase
  setup do
    @microsite = microsites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:microsites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create microsite" do
    assert_difference('Microsite.count') do
      post :create, microsite: { active_microsite: @microsite.active_microsite, background_color: @microsite.background_color, background_image: @microsite.background_image, client_logo: @microsite.client_logo, default_language: @microsite.default_language, description: @microsite.description, font: @microsite.font, font_type: @microsite.font_type, layout_name: @microsite.layout_name, publish: @microsite.publish, title: @microsite.title, user_id: @microsite.user_id, user_template: @microsite.user_template }
    end

    assert_redirected_to microsite_path(assigns(:microsite))
  end

  test "should show microsite" do
    get :show, id: @microsite
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @microsite
    assert_response :success
  end

  test "should update microsite" do
    patch :update, id: @microsite, microsite: { active_microsite: @microsite.active_microsite, background_color: @microsite.background_color, background_image: @microsite.background_image, client_logo: @microsite.client_logo, default_language: @microsite.default_language, description: @microsite.description, font: @microsite.font, font_type: @microsite.font_type, layout_name: @microsite.layout_name, publish: @microsite.publish, title: @microsite.title, user_id: @microsite.user_id, user_template: @microsite.user_template }
    assert_redirected_to microsite_path(assigns(:microsite))
  end

  test "should destroy microsite" do
    assert_difference('Microsite.count', -1) do
      delete :destroy, id: @microsite
    end

    assert_redirected_to microsites_path
  end
end
