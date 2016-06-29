class AddAttrsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :client_logo_file_name, :string
    add_column :users, :client_logo_content_type, :string
    add_column :users, :client_logo_file_size, :integer
    add_column :users, :client_logo_updated_at, :datetime
  end
end
