class CreateMicrositesSurveys < ActiveRecord::Migration
  def change
    create_table :microsites_surveys do |t|
      t.belongs_to :survey, index: true
      t.belongs_to :microsite, index: true
      t.timestamps null: false
      t.timestamps null: false
    end
  end
end
