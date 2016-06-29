class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name
      t.text :description
      t.boolean :status
      t.string :user_id

      t.timestamps null: false
    end
  end
end
