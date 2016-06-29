class CreateCmsPages < ActiveRecord::Migration
  def change
    create_table :cms_pages do |t|
      t.string :title
      t.string :slug, null: false
      t.text :content
      t.string :meta_title
      t.text :meta_keyword
      t.text :meta_description
      t.text :page_css
      t.text :page_js
      t.string :page_class
      t.boolean :status

      t.timestamps null: false
    end
  end
end
