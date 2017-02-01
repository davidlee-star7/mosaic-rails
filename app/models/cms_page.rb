class CmsPage < ActiveRecord::Base
	validates :slug, presence: true
	validates :slug, format: { with: /\A[a-zA-Z0-9_-]+\z/,
    message: "contains invalid charachter`s" }
    validates :slug, length: { minimum: 2 }
    validates :slug, length: { maximum: 100 }
    validates :slug, uniqueness: true
	validates :title, presence: true
	# 

	before_save :filter_content


 	has_many :subpages, :class_name => 'CmsPage', :foreign_key => 'parent_id'
    belongs_to :parent, :class_name => 'CmsPage', :foreign_key => 'parent_id'


    has_many :cms_pages_microsites
    has_many :microsites, :through => :cms_pages_microsites
    belongs_to :user

    has_many :pages_groups
	has_many :groups, :through => :pages_groups

	has_many :extra_fields
	 

	scope :unassigned_pages, -> {
		where("(microsite_id IS NULL OR microsite_id = 0) AND status = TRUE" )
	}
 


	# where("id NOT IN (?)", UsersMicrosite.where(:owner => true )
		#.select(:microsite_id).uniq())
     

	def self.find_main
	CmsPage.find(:all, :conditions => ['parent_id IS NULL'], :order => 'position')
	end

	def self.find_main_public
	CmsPage.find(:all, :conditions => ["parent_id IS NULL and admin != ?", true], :order => 'position')
	end

	# allow only valid contents
	def filter_content 
		self.title = ActionView::Base.full_sanitizer.sanitize(self.title)
		self.slug = ActionView::Base.full_sanitizer.sanitize(self.slug)
		self.meta_title = ActionView::Base.full_sanitizer.sanitize(self.meta_title)
		self.meta_keyword = ActionView::Base.full_sanitizer.sanitize(self.meta_keyword)
		self.meta_description = ActionView::Base.full_sanitizer.sanitize(self.meta_description)
		self.page_class = ActionView::Base.full_sanitizer.sanitize(self.page_class)
	end
 
	def self.to_slug(slug)
	 	ret = slug.strip
	 	ret.gsub! /['`]/,""
	 	ret.gsub! /\s*@\s*/, " at "
	 	ret.gsub! /\s*&\s*/, " and "

	 	ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/,'_'
	 	ret.gsub! /_+/,"_"
	 	ret.gsub! /\A[_\.]+|[_\.]+\z/,""
	 	return ret
	end


	def init
	 	self.status ||= true
	end

 


end
