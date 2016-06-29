json.array!(@pages_groups) do |pages_group|
  json.extract! pages_group, :id
  json.url pages_group_url(pages_group, format: :json)
end
