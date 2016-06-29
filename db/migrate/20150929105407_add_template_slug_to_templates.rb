class AddTemplateSlugToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :template_slug, :string
    add_index :templates, :template_slug, unique: true
  end
end
