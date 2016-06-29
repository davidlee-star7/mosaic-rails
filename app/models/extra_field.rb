class ExtraField < ActiveRecord::Base
	validates :field_name, presence: true 

  belongs_to :cms_page
 
   
end
