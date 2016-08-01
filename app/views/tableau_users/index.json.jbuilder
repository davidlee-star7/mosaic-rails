json.array!(@tableau_users) do |tableau_user|
  json.extract! tableau_user, :id
  json.url tableau_user_url(tableau_user, format: :json)
end
