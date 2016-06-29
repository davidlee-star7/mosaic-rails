class CreateSurveyGroups < ActiveRecord::Migration
  def change
    create_table :survey_groups do |t|

      t.belongs_to :group, index: true
      t.belongs_to :survey, index: true
      

      t.timestamps null: false
    end
  end
end
