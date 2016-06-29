class CreateUsersSurveys < ActiveRecord::Migration
  def change
    create_table :users_surveys do |t|
      t.belongs_to :survey, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
      t.timestamps null: false
    end
  end
end

