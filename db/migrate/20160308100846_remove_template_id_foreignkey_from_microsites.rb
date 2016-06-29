class RemoveTemplateIdForeignkeyFromMicrosites < ActiveRecord::Migration
  def change
  	execute "DROP TABLE #{:templates} CASCADE"
  end
end
