json.array!(@extra_fields) do |extra_field|
  json.extract! extra_field, :id, :cms_page_id, :field_name, :field_value, :field_setting
  json.url extra_field_url(extra_field, format: :json)
end
