class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.text :description
      t.string :logo
      t.boolean :status
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
