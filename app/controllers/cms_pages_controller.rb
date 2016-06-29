class CmsPagesController < ApplicationController
   before_action :authenticate_user!
   before_action :check_permition
    
   layout "dashboard"

	autocomplete :cms_page, :title, :full => true, 
	:extra_data => [:slug,:microsite_id], :column_name => 'slug',
	:scopes => [:unassigned_pages]

	def managegroup
		puts params.inspect
		pagegroup = PagesGroup.where(
			:cms_page_id => params[:cms_page_id], 
			:group_id => params[:group_id])
		msg = ""
		color = ""
		page = CmsPage.find(params[:cms_page_id])
		group = Group.find(params[:group_id])
			if pagegroup.size > 0
			   PagesGroup.destroy(pagegroup.first.id)	
			   msg = "Cms Page #{page.title} successfully unlinked from the group #{group.name}"
			   color = "red"
			else
				PagesGroup.create(
				:cms_page_id => params[:cms_page_id], 
				:group_id => params[:group_id]).save
			    msg = "Cms Page #{page.title} successfully assigned to group #{group.name}"
				color = "green"
			end
		respond_to do |formate|	
		   formate.html{ 
		   	render :json => { 
		   	:status => "Ok", 
		   	:message => msg,
		   	:color => color  }  
		   			   }
		end
	end
	
  private	
  def check_permition
  	#puts params.inspect
    if current_user != nil
      if !current_user.can? params[:action].to_sym, :cms_page
      flash[:alert] = [['You are not authorised to access this page']]
      redirect_to :controller => :admin, :action =>:home
      end
    end 
  end  

	 

end