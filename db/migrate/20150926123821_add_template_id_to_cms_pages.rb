class AddTemplateIdToCmsPages < ActiveRecord::Migration
  def change
    add_column :cms_pages, :template_id, :integer
  end
end
