class Qfield < ActiveRecord::Base
	belongs_to :question
	 validates :fval, presence: true
	 validates :type_id, presence: true


	 #
	 #
	 #
	 def self.addfields(params)

	 	if params[:qoption]!=nil
			params[:qoption].each do |i,option|
				qfield = Qfield.new(
					 :fval=>option ,
					 :type_id => params[:qtype],
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
		if params[:qoption] != nil
				params[:qoption].each do |id,fval|
					field = Qfield.find_by_id(id)
					if field != nil 

						field.fval = fval
						field.save
					else

						qfield = Qfield.new(
							 :fval=>fval ,
							 :type_id => params[:qtype],
							)
						qfield.save	

						
					end
					
				end
		end	

		
	end


	#
	#
	#


end
