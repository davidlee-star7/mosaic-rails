class SurveyGroup < ActiveRecord::Base
	belongs_to :group
    belongs_to :survey

    validates :group_id, :survey_id, presence: true
end
