class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :qfields
  has_many :qhfields

  validates :section_id, presence: true
  validates :title, presence: true
  validates :field_type, presence: true

	def self.field_type 
	return [ :basic => [
		#['Select Question Type',0],
		['Radio Buttons',1],
		['Radio Button Grid',2],
		['Drop Down Menu',3],
		['Checkboxes',4],
		['Textbox',5],
		['Eassy/Long Answer',6],
		['Email',7],
		['Date',8]
					]
			
			]	

	return [ :basic =>	
  				[
  		 		 [:id =>1,:label =>'Radio Buttons',:value =>'Radio Buttons'], 
  				 [:id =>2,:label =>'Radio Button Grid',:value =>'Radio Button Grid'],
  				 [:id =>3,:label =>'Drop Down Menu'],
  				 [:id =>4,:label =>'Checkboxes'],
  				 [:id =>5,:label =>'Textbox'],
  				 [:id =>6,:label =>'Eassy/Long Answer'],
  				 [:id =>7,:label =>'Email'],
  				 [:id =>8,:label =>'Date']
  				 ],
  				 :intermediate =>
  				 	[
  				 		[:id =>1,:label =>'Slider'],
  				 		[:id =>2, :label =>'Star Rating Grid']
  				 	]

  	    		]	
  	 end  		


end	