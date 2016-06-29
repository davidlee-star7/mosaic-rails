class Client < ActiveRecord::Base
	belongs_to :user
	has_many :microsites
    #belongs_to :users_microsite

	validates :name, presence: true
	validates :slug, uniqueness: true

	before_create :publish_client

	before_create :create_slug

	before_update :update_slug

	mount_uploader :logo, AvatarUploader

	def publish_client
		self.status = true	
	end

	def create_slug
		if self.slug.to_s.size > 3
			self.slug = generate_slug self.slug	
		else
			self.slug = generate_slug self.name	
		end
	end

	def update_slug
		if self.slug.to_s.size < 3
			self.slug = generate_slug self.name
		elsif Client.where(:slug => self.slug).size > 1
			self.slug = generate_slug self.slug
		else
			self.slug = self.slug.parameterize	
		end
	end
	##
	def generate_slug name
		tmp_slug = name.parameterize
		client = Client.where(:slug => tmp_slug).last

		if client != nil
			end_ele = client.slug.split("-").last.to_i
			if end_ele > 0
				new_ele = end_ele+1
				tmp_slug = tmp_slug.gsub(end_ele.to_s,new_ele.to_s)
			else
				tmp_slug = tmp_slug.to_s+"-1"
			end
		end
		return tmp_slug
	end

end
