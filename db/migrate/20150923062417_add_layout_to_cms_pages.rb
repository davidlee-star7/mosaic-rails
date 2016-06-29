class AddLayoutToCmsPages < ActiveRecord::Migration
  def change
    add_column :cms_pages, :layout_name, :string
  end
end
