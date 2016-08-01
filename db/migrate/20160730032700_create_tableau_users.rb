class CreateTableauUsers < ActiveRecord::Migration
  def change
    create_table :tableau_users do |t|
      t.string :username
      t.timestamps null: false
    end
  end
end
