class CreateCmsPagesMicrosites < ActiveRecord::Migration
  def change
    create_table :cms_pages_microsites do |t|
      t.belongs_to :microsite, index: true
      t.belongs_to :cms_page, index: true
      t.integer  :position
    end
    add_index :cms_pages_microsites, [:microsite_id, :cms_page_id], unique: true
  end
end
