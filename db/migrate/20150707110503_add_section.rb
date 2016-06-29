class AddSection < ActiveRecord::Migration

  def change
  	create_table(:sections) do |t|

  	  t.integer :survey_id, null: false, default: ""
      t.string 	:title, null:false, default:'Untitled'
      t.text	:description
      t.boolean	:status 

    end

    create_table(:questions) do |t|

  	  t.integer :section_id, null: false, default: ""
      t.string 	:title, null:false, default:''
      t.text	:field_val
      t.boolean	:status
      t.string :field_type
      t.float	:marks	

    end


  	#change_column :sections, :survey_id, :integer, null: false

  end
end
