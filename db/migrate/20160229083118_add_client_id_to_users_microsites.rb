class AddClientIdToUsersMicrosites < ActiveRecord::Migration
  def change
    add_column :users_microsites, :client_id, :integer
  end
end
