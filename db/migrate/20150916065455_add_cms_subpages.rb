class AddCmsSubpages < ActiveRecord::Migration
    def self.up
    add_column :cms_pages, :parent_id, :integer
    add_column :cms_pages, :navlabel, :string
    add_column :cms_pages, :position, :integer
  end

  def self.down
    remove_column :cms_pages, :parent_id
    remove_column :cms_pages, :navlabel
    remove_column :cms_pages, :position
  end
end
