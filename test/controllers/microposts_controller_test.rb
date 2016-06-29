require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase
  setup do
    @micropost = microposts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:microposts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create micropost" do
    assert_difference('Micropost.count') do
      post :create, micropost: { active_microsite: @micropost.active_microsite, background_color: @micropost.background_color, background_image: @micropost.background_image, client_logo: @micropost.client_logo, default_language: @micropost.default_language, description: @micropost.description, font: @micropost.font, font_type: @micropost.font_type, layout_name: @micropost.layout_name, publish: @micropost.publish, title: @micropost.title, user_id: @micropost.user_id, user_template: @micropost.user_template }
    end

    assert_redirected_to micropost_path(assigns(:micropost))
  end

  test "should show micropost" do
    get :show, id: @micropost
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @micropost
    assert_response :success
  end

  test "should update micropost" do
    patch :update, id: @micropost, micropost: { active_microsite: @micropost.active_microsite, background_color: @micropost.background_color, background_image: @micropost.background_image, client_logo: @micropost.client_logo, default_language: @micropost.default_language, description: @micropost.description, font: @micropost.font, font_type: @micropost.font_type, layout_name: @micropost.layout_name, publish: @micropost.publish, title: @micropost.title, user_id: @micropost.user_id, user_template: @micropost.user_template }
    assert_redirected_to micropost_path(assigns(:micropost))
  end

  test "should destroy micropost" do
    assert_difference('Micropost.count', -1) do
      delete :destroy, id: @micropost
    end

    assert_redirected_to microposts_path
  end
end
