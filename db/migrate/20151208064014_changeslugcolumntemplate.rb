class Changeslugcolumntemplate < ActiveRecord::Migration
  def change
  	change_column :templates, :template_slug, :string, :null => true
  end

end
