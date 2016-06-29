json.array!(@tableaus) do |tableau|
  json.extract! tableau, :id, :width, :height, :site_root, :tabs, :toolbar, :ticket, :load_order
  json.url tableau_url(tableau, format: :json)
end
