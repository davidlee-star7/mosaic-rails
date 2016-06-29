json.array!(@played_surveys) do |played_survey|
  json.extract! played_survey, :id, :user_id, :section_id, :option
  json.url played_survey_url(played_survey, format: :json)
end
