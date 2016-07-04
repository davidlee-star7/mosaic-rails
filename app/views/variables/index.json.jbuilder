json.array!(@variables) do |variable|
  json.extract! variable, :id, :name, :vtype, :identifier
  json.url variable_url(variable, format: :json)
end
