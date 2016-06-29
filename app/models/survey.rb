class Survey < ActiveRecord::Base
	has_many :sections
	has_many :qfields, through: :sections
	has_many :qhfields, through: :sections
	has_many :played_surveys, through: :sections
	
	
	belongs_to :user

	validates :name, presence: true 
	validates :user_id, presence: true 
	validates :thank_page_title, presence: true 

	has_many :survey_groups
	has_many :groups, :through => :survey_groups
	
    has_many :users_survey
    has_many :users, :through => :users_survey

 	has_many :microsites_survey
    has_many :microsites, :through => :microsites_survey

    scope :unassigned_survey, -> {
    	where("status = TRUE")
    } 


    def show_slug

     self.name.to_s.gsub(":"," ")+" : "+self.id.to_s
    	
    end

	def self.addNew (params)

		 survey = Survey.new(
		 	:name =>params[:name],
		 	:user_id => params[:user_id],
		 	:status => true,
		 	:thank_page_title => params[:thank_page_title],
		 	:thank_page_description => params[:thank_page_description],
		 	)
		 if survey.save
		 	section = Section.new(
		 		:survey_id =>survey.id,
		 		:title => 'Untitled',
		 		:status => true
		 		)
		 	section.save
		 end

		return survey 

	end




end
