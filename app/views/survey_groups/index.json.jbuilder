json.array!(@survey_groups) do |survey_group|
  json.extract! survey_group, :id, :survey_id, :group_id
  json.url survey_group_url(survey_group, format: :json)
end
