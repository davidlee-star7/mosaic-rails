class PlayedSurvey < ActiveRecord::Base

	belongs_to :section
	belongs_to :user

	validates :user_id, presence: true
	validates :section_id, presence: true





	def self.createNew(params)

		#playedsurvey = PlayedSurvey.where("user_id = ? AND section_id = ?",{user_id: params[:user_id], section_id: params[:section_id] })
		playedsurvey = PlayedSurvey.where("user_id = (?) AND section_id = (?) ", params[:user_id],  params[:section_id] )

		if playedsurvey.size > 0
			return 'You can only play this survey one time'
		else 

			playedsurvey = PlayedSurvey.new(:user_id => params[:user_id],:option => params[:option],:section_id => params[:section_id])

			if playedsurvey.save

					return true
				else
					return playedsurvey.errors
				
			end
			
		end
			

	end



	 

end
