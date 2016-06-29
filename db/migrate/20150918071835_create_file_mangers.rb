class CreateFileMangers < ActiveRecord::Migration
  def change
    create_table :file_mangers do |t|
      t.string :name
      t.string :size
      t.string :attachment

      t.timestamps null: false
    end
  end
end
