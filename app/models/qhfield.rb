class Qhfield < ActiveRecord::Base
	belongs_to :question
	validates :fval, presence: true

	#
	#
	#
	def self.addfields(params)

	 	if params[:qhoption]!=nil
			params[:qhoption].each do |i,option|
				qfield = Qhfield.new(
					 :fval=>option
					)
				qfield.save
			end
		end

		return true
	end

	#
	#
	#

	def self.updatefields(params)
		if params[:qhoption] != nil

				params[:qhoption].each do |id,fval|
					field = Qhfield.find_by_id(id)
					if field != nil 

						field.fval = fval
						field.save
					else

						qhfield = Qhfield.new(
							 :fval=>fval 
							)
						qhfield.save	
						
					end
					
				end
		end		

		
	end

	#
	#
	#

end
