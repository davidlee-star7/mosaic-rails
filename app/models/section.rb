class Section < ActiveRecord::Base
	belongs_to :survey
	has_many :questions
	has_many :played_surveys  

validates :title, presence: true 
validates :survey_id, presence: true


	def self.next(params)
		section = Section.find(params[:section_id])
		survey = section.survey
		return survey.sections.where("id > ?",params[:section_id]).first
	end

	def self.prev(params)
		section = Section.find(params[:section_id])
		survey = section.survey
		return survey.sections.where("id < ?",params[:section_id]).first
	end





end	