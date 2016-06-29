json.array!(@microsites_groups) do |microsites_group|
  json.extract! microsites_group, :id
  json.url microsites_group_url(microsites_group, format: :json)
end
