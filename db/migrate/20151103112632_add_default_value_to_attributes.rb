class AddDefaultValueToAttributes < ActiveRecord::Migration
def up
change_column :microsites, :publish, :boolean, :default => true
change_column :microsites, :active_microsite, :boolean, :default => true
change_column :cms_pages, :status, :boolean, :default => true
change_column :users, :status, :boolean, :default => true


end

def down
change_column :microsites, :publish, :boolean, :default => nil
change_column :microsites, :publish, :boolean, :default => nil
change_column :cms_pages, :status, :boolean, :default => nil
change_column :users, :status, :boolean, :default => nil

end
end
