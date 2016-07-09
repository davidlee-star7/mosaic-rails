class PageController < ApplicationController
  before_action :authenticate_user!, :only => [:client_dashboard, :preview_microsite, :show]
  protect_from_forgery with: :exception
  #before_filter :connect_to_tableau, :only => [:client_dashboard,:preview_microsite]
  before_action :check_permition

  layout "page", :only => [ :cms, :client_dashboard ]
  layout 'none', :only => [ :unpublished ]
  layout 'microsite', :only => [ :preview_microsite ]


  def login
    if params[:login] && params[:login][:username] && params[:login][:username].present?
      session[:current_user] = params[:login][:username]
      redirect_to iframe_reports_path
    else
      flash[:error] = "You must specify a username to log in"
      redirect_to reports_url
    end
  end

  def logout
    session[:current_user] = nil
    redirect_to reports_path
  end
 
  #
  def show

  end

  #
  def index
    
  end

  def add_row
    respond_to do |format|
      format.html{ "/page/add_row" }
    end
    
  end

  def client_dashboard
    @task = params[:task]
    @tableau = params[:id] != nil ? Tableau.find(params[:id]) : nil
    @msg = []
    respond_to do |format|
      if @tableau != nil 
        format.html{  render :'page/client/dashboard' }
      else
        format.html{  render :'page/client/reports'   }
      end
    end
  end

  ##
  def enterotp

  end
  ##
  def check_two_factor_authentication
    @userr = User.find_by(id:params[:id])
    if params[:otp].to_s == @userr.otp_secret_key.to_s
        if @userr.present?
          flash[:notice] = "You have been verified successfully"
          key = ROTP::Base32.random_base32
          @userr.update_attributes(:otp_secret_key => key)
          sign_in(@userr)
          redirect_to root_path
        else
          redirect_to new_user_session_path, 
          :flash => { :error => "We are unable to verify you. Try to login again" }
        end
    else
      redirect_to new_user_session_path, 
          :flash => { :error => "Your link has been expired. Try to login again"  }
    end
  end

  #
  #
  def cms
    @cmspage = CmsPage.where('slug = ?',params[:slug])
    @microsite = nil
    @groups = ExtraField.all.where(:cms_page_id => @cmspage.first.id).select(:field_group).distinct

    if @cmspage.present?
      if @cmspage[0].microsite_id != nil
        if Microsite.exists?(@cmspage[0].microsite_id)
          @microsite = Microsite.find(@cmspage[0].microsite_id)
        end
      end
    
      # if @microsite.publish
      @type = params[:type]
      respond_to do |format|
        if @cmspage.size > 0
        @cmspage = @cmspage.first
        format.html{ render 'page/CMS/index.html.erb' } 
        else
        format.html{ render 'page/CMS/notfound.html.erb' }    
        end
      end
    else
      flash[:notice] = "Page Not found"
      redirect_to root_path
    end
  end
 
  def unpublished

  end

  #GET ':client_slug/:microsite_slug'
  #GET ':client_slug/:microsite_slug/:cms_page_slug'
  #GET ':client_slug/:microsite_slug/profile'
  def preview_microsite
    @msg = []
    @cmspage = nil
    @user = nil
    @extra_fields = nil
    @groups = nil
   
    @microsite = Microsite.find_by(:slug => params[:microsite_slug])
    if has_same_group(current_user,@microsite).any?
    else
      redirect_to '/page/show', :alert => "You are not Authorized to Access this page."
      return false
    end
  
    @client = Client.find_by(:slug => params[:client_slug])

    if params[:cms_page_slug] == "profile"
      @user = current_user
    else
      if (params[:cms_page_slug].to_s !='')
            @cmspage =  CmsPage.find_by(:slug => params[:cms_page_slug])
      elsif @microsite.cms_page_id.to_i > 0
            @cmspage =  CmsPage.find_by(:id => @microsite.cms_page_id)  
            if @cmspage == nil
              @msg << "Default Page deleted, Please set new one."
            end 
      else
            @cmspage = @microsite.cms_pages.first
      end

      if @cmspage == nil 
         @msg << "No default page found"
      end
    end


    @body_class = "microsite-#{@microsite.id}-client#{@client.id}"

    if @cmspage != nil
       @body_class = @body_class + "-page-#{@cmspage.id}"
       @groups = ExtraField.all.where(:cms_page_id => @cmspage.id).select(:field_group).order("field_group DESC").distinct
    end


    if @microsite == nil 
      @msg << "Microsite Not found"
    end

    if @client == nil 
      @msg << "Client Not found"
    end



    respond_to do |format|
      if @msg.size > 0
        format.html{ render 'page/CMS/notfound' }
      else
        
        if @user != nil
          format.html{ render '/page/profile' }
        else
          format.html{ render '/page/preview_microsite' }
        end
      end
    end

  end

 

  private

  def check_permition
    if current_user != nil
      if !current_user.can? params[:action].to_sym, :page
      flash[:alert] = [['You are not authorised to access this page']]
      redirect_to :controller => :admin, :action =>:home
      end
    end 
  end  

  def has_same_group res1, res2
    if current_user.can? :preview_microsite, :page 
      return [1,2,3]
    end

    if res1 == nil || res2 == nil
      return []
    end
    group1 = res1.groups.map{|g| g.id  }
    group2 = res2.groups.map{|g| g.id  }
    grouped = group1 & group2
    return  grouped
  end



end
