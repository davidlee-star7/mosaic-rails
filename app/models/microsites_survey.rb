class MicrositesSurvey < ActiveRecord::Base
	belongs_to :microsite
  belongs_to :survey
end
