class CreatePagesGroups < ActiveRecord::Migration
  def change
    create_table :pages_groups do |t|
	  t.belongs_to :group, index: true
      t.belongs_to :cms_page, index: true
      t.timestamps null: false
    end
  end
end
