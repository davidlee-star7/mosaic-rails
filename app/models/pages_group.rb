class PagesGroup < ActiveRecord::Base
	belongs_to :group
    belongs_to :cms_page

    validates :group_id, :cms_page_id, presence: true


    def self.updatepages(params)
    	groups = params[:groups]
     	pages = params[:pages]

     	pages.each do |p|
     		p = p.kind_of?(Array) ? p.first : p
     		cms_page = CmsPage.find(p)
     		groups.each do |g|
     			if(!cms_page.groups.exists?(g.first))
     			pagegroup = PagesGroup.new()
     			pagegroup.group_id = g.first.to_i
     			pagegroup.cms_page_id = p.to_i
     			pagegroup.save
     			end
     		#	puts "new added: "
     		#	puts pagegroup.inspect
     		end
     	end

     #	pg

     	cms_page = params[:cms_page]

     	if cms_page != nil
     		page_id = pages.first.to_i
	     	page = CmsPage.find(page_id)
	     	pagegroups = page.groups
	     	exists_groups_ids = pagegroups.map{ |pg| pg.id }
	     	groups_ids_after_update = groups.map { |gau| gau.first.to_i }
	     	diff_groups = exists_groups_ids.to_a - groups_ids_after_update.to_a
	     	if diff_groups.size > 0
	     	 diff_groups.map{|gid| page.groups.destroy(gid) }
	     	end
     	end
     	


     	return true
    end
end
