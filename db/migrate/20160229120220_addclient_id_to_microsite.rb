class AddclientIdToMicrosite < ActiveRecord::Migration
  def change
  	add_column :microsites, :client_id, :integer
  end
end
