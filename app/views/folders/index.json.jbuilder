json.array!(@folders) do |folder|
  json.extract! folder, :id, :name
  json.url folder_url(folder, format: :json)
end
