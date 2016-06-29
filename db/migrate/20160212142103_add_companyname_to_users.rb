class AddCompanynameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company_name, :string
    add_column :users, :associated_client, :string
  end
end
