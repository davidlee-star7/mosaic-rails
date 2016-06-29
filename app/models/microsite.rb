class Microsite < ActiveRecord::Base
    mount_uploader :client_logo, MicrositeUploader
    mount_uploader :background_image, MicrositeUploader
    #extend FriendlyId
    #friendly_id :slug, use: :history
    # method used for mepping
    # To identify who is client owner of microsite we have added owner field in UsersMicrosite table 
    # so the user that is market owner = true in UsersMicrosite is the clent if this microsite
    # and rest users in UsersMicrosite table are the basic users of table
    # validates :slug, uniqueness: true #
    validates :title, presence: true 
    validates :slug, presence: true, uniqueness: true 

    #belongs_to :user
    has_many :cms_pages, :dependent => :destroy
    before_validation :create_slug
     
    has_many :users_microsite
    has_many :users, :through => :users_microsite  
    belongs_to :user
    belongs_to :client
    has_many :microsites_survey
    has_many :surveys, :through => :microsites_survey
    has_many :microsites_group
    has_many :groups, :through => :microsites_group

    scope :filter_users, -> {
      # where("id NOT IN (?)", UsersMicrosite.where(:owner => true ).select(:microsite_id).uniq())
      # where("id NOT IN (?)", UsersMicrosite.where(:owner => true ).select(:microsite_id).uniq())
    }

    #   
    def to_param
    "#{title}".parameterize
    end
    
    #
    private
    def create_slug
       # Rails.logger.warn "test"
       # Rails.logger.warn self.title.parameterize
       if self.slug.to_s == "" 
           self.slug = self.title.parameterize
       else
           self.slug = self.slug.parameterize
       end
    end

end