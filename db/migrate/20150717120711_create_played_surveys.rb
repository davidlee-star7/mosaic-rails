class CreatePlayedSurveys < ActiveRecord::Migration
  def change
    create_table :played_surveys do |t|
      t.integer :user_id
      t.integer :section_id
      t.text :option

      t.timestamps null: false
    end
  end
end
