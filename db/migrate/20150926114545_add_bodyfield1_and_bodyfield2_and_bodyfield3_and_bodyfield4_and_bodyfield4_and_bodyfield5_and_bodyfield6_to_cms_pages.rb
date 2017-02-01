class AddBodyfield1AndBodyfield2AndBodyfield3AndBodyfield4AndBodyfield4AndBodyfield5AndBodyfield6ToCmsPages < ActiveRecord::Migration
  def self.up
    add_column :cms_pages, :bodyfield1, :text
    add_column :cms_pages, :bodyfield2, :text
    add_column :cms_pages, :bodyfield3, :text
    add_column :cms_pages, :bodyfield4, :text
    add_column :cms_pages, :bodyfield5, :text
    add_column :cms_pages, :bodyfield6, :text
  end

  def self.down
    remove_column :cms_pages, :bodyfield1, :text
    remove_column :cms_pages, :bodyfield2, :text
    remove_column :cms_pages, :bodyfield3, :text
    remove_column :cms_pages, :bodyfield4, :text
    remove_column :cms_pages, :bodyfield5, :text
    remove_column :cms_pages, :bodyfield6, :text

  end




end
