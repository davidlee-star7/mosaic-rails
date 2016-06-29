class CreateUsersMicrosites < ActiveRecord::Migration
  def change
    create_table :users_microsites do |t|
 	  t.belongs_to :microsite, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
      t.timestamps null: false
    end
  end
end
