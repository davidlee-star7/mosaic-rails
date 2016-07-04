json.array!(@groups_variables) do |groups_variable|
  json.extract! groups_variable, :id, :group_id, :variable_id, :value
  json.url groups_variable_url(groups_variable, format: :json)
end
