class AddAbilityToAbility < ActiveRecord::Migration
  def change
  	create_table :uability do |t|
  	  t.string :name
  	  t.string :uabilit_from
  	  t.boolean :status
      t.timestamps null: false
    end
  end
end
