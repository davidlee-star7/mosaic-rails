class UsersMicrosite < ActiveRecord::Base
	belongs_to :microsite
  belongs_to :client
  belongs_to :user

  
  validate :check_for_unique_owner



  def check_for_unique_owner

  	users_microsite = UsersMicrosite.where(
  		:user_id => self.user_id, 
  		:microsite_id => self.microsite_id,
  		:owner => true
  		)
  	if !users_microsite.blank?
  		errors.add(:user_id, "Microsite can't have more than one Client! ")
  	end
  	
  end

end
