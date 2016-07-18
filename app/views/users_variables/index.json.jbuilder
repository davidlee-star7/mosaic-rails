json.array!(@users_variables) do |users_variable|
  json.extract! users_variable, :id, :user_id, :variable_id, :value
  json.url users_variable_url(users_variable, format: :json)
end
