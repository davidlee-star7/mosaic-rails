class CreateMicrositesGroups < ActiveRecord::Migration
  def change
    create_table :microsites_groups do |t|
      t.belongs_to :group, index: true
      t.belongs_to :microsite, index: true
      t.timestamps null: false
    end
  end
end
