json.array!(@qfields) do |qfield|
  json.extract! qfield, :id, :fval, :type_id, :section_id
  json.url qfield_url(qfield, format: :json)
end
