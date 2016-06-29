class AddMicrositeIdUserIdToCmsPages < ActiveRecord::Migration
  def change
    add_column :cms_pages, :microsite_id, :integer
    add_column :cms_pages, :user_id, :integer
  end
end
