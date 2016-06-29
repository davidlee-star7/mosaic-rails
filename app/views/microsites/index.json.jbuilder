json.array!(@microsites) do |microsite|
  json.extract! microsite, :id, :title, :default_language, :active_microsite, :description, :publish, :user_template, :layout_name, :client_logo, :background_color, :background_image, :font, :font_type, :user_id
  json.url microsite_url(microsite, format: :json)
end
