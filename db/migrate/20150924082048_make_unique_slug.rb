class MakeUniqueSlug < ActiveRecord::Migration


    def self.up
    add_column :microsites, :slug, :string, :unique => true
  end

  def self.down
    remove_column :microsites, :slug
  end


end
