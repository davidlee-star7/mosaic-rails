class Addfieldstotemplates < ActiveRecord::Migration
  def change
    add_column :templates, :label1, :string
    add_column :templates, :label2, :string
    add_column :templates, :label3, :string
    add_column :templates, :label4, :string
    add_column :templates, :label5, :string
    add_column :templates, :label6, :string
    add_column :templates, :label7, :string
  end
end
