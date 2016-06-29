require 'test_helper'

class PlayedSurveysControllerTest < ActionController::TestCase
  setup do
    @played_survey = played_surveys(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:played_surveys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create played_survey" do
    assert_difference('PlayedSurvey.count') do
      post :create, played_survey: { option: @played_survey.option, section_id: @played_survey.section_id, user_id: @played_survey.user_id }
    end

    assert_redirected_to played_survey_path(assigns(:played_survey))
  end

  test "should show played_survey" do
    get :show, id: @played_survey
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @played_survey
    assert_response :success
  end

  test "should update played_survey" do
    patch :update, id: @played_survey, played_survey: { option: @played_survey.option, section_id: @played_survey.section_id, user_id: @played_survey.user_id }
    assert_redirected_to played_survey_path(assigns(:played_survey))
  end

  test "should destroy played_survey" do
    assert_difference('PlayedSurvey.count', -1) do
      delete :destroy, id: @played_survey
    end

    assert_redirected_to played_surveys_path
  end
end
