class AddDefaultpageToMicrosites < ActiveRecord::Migration
  def change
    add_column :microsites, :cms_page_id, :integer
  end
end
