json.array!(@file_mangers) do |file_manger|
  json.extract! file_manger, :id, :name, :size, :attachment
  json.url file_manger_url(file_manger, format: :json)
end
