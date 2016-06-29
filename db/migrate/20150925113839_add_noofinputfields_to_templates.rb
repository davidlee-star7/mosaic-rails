class AddNoofinputfieldsToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :noofinputfields, :integer
  end
end
