class CreateMicrosites < ActiveRecord::Migration
  def change
    create_table :microsites do |t|
      t.string :title
      t.string :default_language
      t.boolean :active_microsite
      t.text :description
      t.boolean :publish
      t.string :user_template
      t.string :layout_name
      t.string :client_logo
      t.string :background_color
      t.string :background_image
      t.string :font
      t.string :font_type
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :microsites, :users
  end
end
