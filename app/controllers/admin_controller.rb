class AdminController < ApplicationController

  helper_method :noOfUsersPlayedThisSurvey, :logged_in?
	before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :check_permition, except: [:newcmspage, :create_cmspage, :listcmspages, :create_slug]
  before_action :set_survey, only: [:show, :edit, :update, :destroy]
  layout "dashboard"
  
  #
  def noOfUsersPlayedThisSurvey(survey)
    sections = survey.sections
    count = 1
    sections.each_with_index do |section,i|
      if section !=nil
        pss = section.played_surveys.select('user_id').group(:user_id).count
        if pss != nil
          return pss.size
        end 
      end
    end
  end


  #
  def importuserscsv
    respond_to do |format|
      format.html{ render 'admin/CSV/users/new' }
    end
  end

  #
  def processuserscsv
    require 'csv'
    file = params[:file]
    users_hash = []
    user = nil
    CSV.foreach(file.path, headers: true) do |row|

     user_hash = row.to_hash
     #check if user 
     get_user = User.where(:email =>user_hash["email"])
     if get_user.size == 0
      user = [:first_name =>user_hash['first_name'],
              :last_name =>user_hash['last_name'],
              :display_name =>user_hash['display_name'],
              :email =>user_hash['email'],
              :password =>user_hash['password'],
              :admin => false
            ]
      user = User.addUser_ext(user.first)
     end
    end

    if user != true
      flash['alert'] = user 
    else
      flash['notice'] = 'CSV Exported Successfully'
    end 
    
    respond_to do |format|
      format.html{ redirect_to '/admin/users' }
    end

  end

  #
  def home
  end
  #
 
  #
  def show
  end
  

  #
  def index
  	
  end
 

  # create new user 
  #
  def addUser

    @user = User.new 
    @roles = Role.listRoles
    @role = nil
    @groups = nil 

    respond_to do |format|
      if params[:action_type] == "addUser"
         @user = User.create user_params
         @role = params[:role]
         @groups = params[:group]
         if @role != nil
            @role.each do |r|
              @user.add_role(r[1])
            end
         end

         if @groups != nil
            @user.update_groups params
         end
         
          
         if @user.save
           format.html{ redirect_to :action => "listUsers", notice: 'User was successfully created.'}
         else
           format.html{ render "/admin/addUser" }
         end
      else
           format.html{ render "/admin/addUser" }   
      end

    end

   
  end

  #
  # list all users in the site
  #
  def listUsers
     @roles = Role.listRoles
     @groups = Group.all
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else 
      @users = User.order('created_at DESC')
    end
  end	

  USERNAME_COL = 0
  FIRST_NAME_COL = 1
  LAST_NAME_COL = 2
  DISPLAY_NAME_COL = 3
  EMAIL_COL = 4
  PASSWORD_COL = 5
  GROUP_COL = 6
  # GET upload_users
  def upload_users
    @errors = []
    @success = []
    @dispatch = params[:csv_file]
    count = 0
    if params[:task] == "Upload_users_csv"
      if @dispatch != nil && @dispatch.size

        CSV.foreach(@dispatch.path) do |row|
          if count > 0
            group_name = row[GROUP_COL]
            group = Group.find_by_name(group_name)
            if group.nil?
              group = Group.create(
                name: group_name,
                default_language: 'english'
              )
            end
            user = User.create(
                    :username => row[USERNAME_COL], 
                    :first_name => row[FIRST_NAME_COL],
                    :last_name => row[LAST_NAME_COL],
                    :display_name => row[DISPLAY_NAME_COL], 
                    :email => row[EMAIL_COL], 
                    :password => row[PASSWORD_COL],
                    :status => true, 
                    :admin => false,
                    :confirmed_at => DateTime.now
                  )
            if user.errors.any?
              @errors << [user,user.errors.full_messages]
            else
              user.save
              group.users << user
               @success << user
            end
             
          end
          count = count + 1
        end
      else
        @errors << [nil,["Invalid File!"]]
      end
    end

   # dd
  end


  def edit_user_individual
     @user = User.find(params[:user_ids])

  end


  def bulkupdaterole
    if params[:task].present? and params[:task] == "bulkupdaterole"
    @users = User.find(params[:userids])  # get all users from ids
    role = Role.find(params[:role])
    begin
        @users.each do |us|   # loop each user
          us.roles.delete_all   # deleting existing roles from user
          # us.add_role :"#{params[:role]}"   # using rolify add_role
          us.roles << role
        end
        respond_to do |format|
         msg = { :status => "ok", :message => "Roles updated successfully", :html => "<b>Roles updated successfully</b>" }
         format.json  { render :json => msg }
        end
  rescue Exception => e
    #puts "caught exception #{e}! ohnoes!"
  respond_to do |format|
  msg = { :status => "ok", :message => "caught exception #{e}! ohnoes!", :html => "<b>caught exception #{e}! ohnoes!</b>" }
  format.json  { render :json => msg }
  end
  end
  end
  
  if params[:task].present? and params[:task] == "bulkupdategroup"
  @users = User.find(params[:userids])  # get all users from ids
  group = Group.find(params[:group])
  begin
  @users.each do |us|   # loop each user
  us.groups.delete_all  # deleting existing roles from user
  
  us.groups << group
  end
  respond_to do |format|
  msg = { :status => "ok", :message => "Group updated successfully", :html => "<b>Group updated successfully</b>" }
  format.json  { render :json => msg }
  end
  rescue Exception => e
   #puts "caught exception #{e}! ohnoes!"
  respond_to do |format|
  msg = { :status => "ok", :message => "caught exception #{e}! ohnoes!", :html => "<b>caught exception #{e}! ohnoes!</b>" }
  format.json  { render :json => msg }
  end
  end
  end
  #
  if params[:task].present? and params[:task] == "bulkdisableuser"
  @users = User.find(params[:userids])
  @users.each do |rt|
  rt.status = false
  rt.save
  end
  flash[:notice] = 'Users disabled Successfully!'
  respond_to do |format|
  msg = { :status => "ok", :message => "Disabled successfully", :html => "" }
  format.json  { render :json => msg }
  end
  end
  #
 if params[:task].present? and params[:task] == "bulkdeleteuser"
  @users = User.find(params[:userids])
  @users.each do |rt|
  # rt.status = false
  # rt.save
  rt.destroy
  end
  flash[:notice] = 'Users deleted Successfully!'
  respond_to do |format|
  msg = { :status => "ok", :message => "Deleted successfully", :html => "" }
  format.json  { render :json => msg }
  end
  end
  #
  end

  #
  #edit user by id
  #same is used to update user by id
  #
  def editUser
    @autherror = []
    @tparm = params[:id]

    if params[:action_type] =='update'
      user = User.update_ext(params)
      if user.errors != nil
       @autherror = user 
      end
    end

  	user_id = Integer(@tparm)

  	@user = User.find(user_id)
    @user_fields = User.user_fields(current_user)
    @roles = Role.listRoles
    @testp = params
    @user_variables = @user.users_variables
  end	
  #
  # edit survey

  #
  def editsurvey
    @survey = Survey.find(params[:id])
  end

  #
  # delete user function
  #
  def delUser
    user_id = Integer(params[:id])
    if user_id > 0
      user = User.find(user_id)
      if user.admin 
        flash[:alert] = [['You can not delete Admin Users']]
      else
          roles = Role.listRoles
          roles.each do |role| 
            if user.has_role?role[0]
             user.remove_role(role[0]) 
            end
          end
         admin = Admin.exists?(user.id)
         if admin !=false
             Admin.find(user.id).destroy 
         end    
         user.destroy
      end
    end
    redirect_to :action => "listUsers"
  end


  #
  # create new survey
  #

  def addSurvey
    @client_id = 0
    if params[:action_type]=='addSurvey'
      @survey = Survey.addNew(params)
      respond_to do |format|
        if @survey.save
          format.html { redirect_to :action => "buildsurvey", :id =>@survey.id }
          format.json { render :show, status: :created, location: @survey }
        else
          format.html { render :addSurvey }
          format.json { render json: @survey.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def buildsurvey
    id = params[:id]
    @survey = Survey.find(id)
    @sections = Section.where(survey_id: @survey.id).take(100) 
    @field_type = Question.field_type
  end

  #
  # manage Survey
  #

  def manageSurvey
    @errors = @survey = []
    groups = params[:groups]
    survey = params[:survey]

    if current_user.admin
      @survey = Survey.all
    else
      @survey = current_user.surveys
    end

    if params[:task] == "survey_to_group"
      
      if !groups
        @errors << "You must select Grous from the list, assign to Survey!"
      end

      if !survey
        @errors << "You must select Surveys to assign Groups!"
      end

      if @errors.size > 0
        return false
      end
    end
    
  end


  #
  # Role functions
  #

  def listroles
      @roles = Role.all
  end

  def editrole
    @role = Role.find(params[:role_id])

  end

  def updaterole
     @role = Role.find(params[:id])
     @role.update(name: params[:Role][:name].gsub(' ','_'))

     respond_to do |format|
      format.html { redirect_to :controller => :admin, :action =>:listroles  }
     end

  end

  def listRoleCapability
    @listability = Ability.abilitycollection
    puts @listability
    @role = Role.find(params[:role_id])
   ## @listability = AdminController.instance_methods(false)
  end


  #
  #
  #
  def setPermition
    @role = Role.find(params[:role_id])
    if params[:button_is] == 'true'
      @permition = @role.permitions.new(
        :action => params[:paction],
        :action_class => params[:action_class]
      );
      @permition.save 
    else
      @permition = @role.permitions.where(:action => params[:paction],
      :action_class => params[:action_class])
      @permition.destroy_all
    end
    respond_to do |format|
      @data = @permition
      format.html { 
        #render 'test'
        render 'setPermition'
      }
    end
  end

  #
  #
  #
  def played_surveys
    @surveys = Survey.all
  end

  #
  #
  #
  # GET admin/newcmspage
  def newcmspage
    @cmspage = CmsPage.new
    @microsite = nil
    if params[:id] != "" && params[:id] != nil
       @microsite = Microsite.find(params[:id])
    end
   
    respond_to do |format|
     format.html { render 'admin/CMS/newcmspage' }
    end
  end

  def addexistingpages
   @microsite = Microsite.find(params[:id])
   @pages = []
   @errors = []
   @success = []
    if params[:task] == "assign-pages-to-microsite"
      @pages = params[:pages]
      if @pages.size > 0
        @pages.first.split(",").each do |p|
            page = CmsPage.find_by(:slug => p)
            if page == nil
              @errors << "CMS Page <i>#{p}</i> Not found in the system!"
            else
              if page.microsite_id.to_i > 0
                @errors << "CMS Page <i>#{p}</i> al ready assigned to another microsite"
              else
                page.microsite_id = @microsite.id 
                page.save
                @success << "CMS Page <i>#{p}</i> successfully added to Microsite <span>#{@microsite.title}</span>"
              end
            end      
        end
      end   
    end
    respond_to do |format|
     format.html { render 'admin/CMS/addexistingpages' }
    end
  end

  # PATCH admin/create_cmspage
  def create_cmspage
    # Rails.logger.warn "test1"
    # Rails.logger.warn params[:cms_page][:slug]
    # Rails.logger.warn "test2"
    cms_page_params = [
        :title =>params[:cms_page][:title],
        :slug =>params[:cms_page][:slug],
        :content =>params[:cms_page][:content],
        :meta_title =>params[:cms_page][:meta_title],
        :meta_keyword =>params[:cms_page][:meta_keyword],
        :meta_description =>params[:cms_page][:meta_description],
        :page_css =>params[:cms_page][:page_css],
        :page_js =>params[:cms_page][:page_js],
        :page_class =>params[:cms_page][:page_class],
        :status =>params[:cms_page][:status],
        :parent_id =>params[:cms_page][:parent_id],
        :layout_name =>params[:cms_page][:layout_name],
        :microsite_id =>params[:cms_page][:microsite_id],
        :user_id =>current_user.id,
        :bodyfield1 =>params[:cms_page][:bodyfield1],
        :bodyfield2 =>params[:cms_page][:bodyfield2],
        :bodyfield3 =>params[:cms_page][:bodyfield3],
        :bodyfield4 =>params[:cms_page][:bodyfield4],
        :bodyfield5 =>params[:cms_page][:bodyfield5],
        :bodyfield6 =>params[:cms_page][:bodyfield6],
        :template_id =>params[:cms_page][:template_id]
       ]
    @cmspage = CmsPage.new(cms_page_params.first)

    respond_to do |format|
      if @cmspage.save
         extraelemrnt =  params[:extraelemrnt]
         if extraelemrnt != nil && extraelemrnt != ""
            extraelemrnt.each do |element|
              if element != "" && element != t("CREATE_NEW_OBJECT_LABEL")
                ExtraField.create(:cms_page_id => @cmspage.id, :field_name => element ).save
              end
            end 
         end
       msg = "Successfully created #{view_context.link_to('page', @cmspage)}."
        Rails.logger.warn msg
         format.html { redirect_to controller: :admin, action: :editpage, cms_page_id:@cmspage.id , notice: msg.html_safe }
        else
         format.html { render 'admin/CMS/newcmspage' }
      end
    end
  end


  #
  #
  #
  def create_slug
    respond_to do |format|
      format.json{ render :json => CmsPage.to_slug(params[:slug]) }
    end
  end

  #
  #
  #
  def listcmspages
    @cmspages = []
   if current_user.admin?
   @cmspages = CmsPage.order(updated_at: :desc)
   @errors = []
   @message = []
   else
    if params[:id].present?
    @cmspages = CmsPage.where(:microsite_id=> params[:id], :user_id => current_user.id ) 
    else
      #only show cms pages allowed by crrent user
      if current_user.microsites != nil
        current_user.microsites.each do |m|
          if m.cms_pages != nil
            m.cms_pages.each do |p|
              @cmspages << p
            end
          end
          
        end
      end     
    end
   end

   if params[:task] == "cmspages_to_group"
     groups = params[:groups]
     pages = params[:pages]

      if !groups
        @errors << "You must select Grous from the list, assign to Pages!"
      end

      if !pages
        @errors << "You must select Pages to assign Groups!"
      end

      if @errors.size > 0
        respond_to do |format|
         format.html{ render 'admin/CMS/listcmspages' }
        end
        return false
      else
        PagesGroup.updatepages(params)
        @message << "Pages and Groups saved Successfully."
      end

   end

   respond_to do |format|
     format.html{ render 'admin/CMS/listcmspages' }
   end

  end



  #
  def editpage
    @cmspage = CmsPage.find(params[:cms_page_id])
    @groups = ExtraField.where(:cms_page_id => @cmspage.id ).select(:field_group).order("field_group DESC").distinct
    session[:edit_page_last_id] = @cmspage.id 
    session[:edit_page_back] = nil
    @microsite = @cmspage.microsite
    respond_to do |format|
        format.html{ render 'admin/CMS/editpage' }
    end
  end


  def unlinkcmspage
    page = CmsPage.find(params[:page_id])
    microsite_id = page.microsite_id
    page.microsite_id = ""
    page.save
    respond_to do |format|
      format.html{  redirect_to "/microsites/#{microsite_id}/" }
    end
  end



  def update_cmspage
    cmspage = CmsPage.find(params[:cms_page_id])
    session[:edit_page_last_id] = cmspage.id 

    cmspage.title = params[:cms_page][:title]
    cmspage.slug = params[:cms_page][:slug]
    cmspage.content = params[:cms_page][:content]
    cmspage.meta_title = params[:cms_page][:meta_title]
    cmspage.meta_keyword = params[:cms_page][:meta_keyword]
    cmspage.meta_description = params[:cms_page][:meta_description]
    cmspage.page_css = params[:cms_page][:page_css]
    cmspage.page_js = params[:cms_page][:page_js]
    cmspage.page_class = params[:cms_page][:page_class]
    cmspage.status = params[:cms_page][:status],
    cmspage.parent_id = params[:cms_page][:parent_id],
    cmspage.layout_name = params[:cms_page][:layout_name],
    cmspage.microsite_id = params[:cms_page][:microsite_id],
    cmspage.user_id = current_user.id,
    cmspage.bodyfield1 = params[:cms_page][:bodyfield1],
    cmspage.bodyfield2 = params[:cms_page][:bodyfield2],
    cmspage.bodyfield3 = params[:cms_page][:bodyfield3],
    cmspage.bodyfield4 = params[:cms_page][:bodyfield4],
    cmspage.bodyfield5 = params[:cms_page][:bodyfield5],
    cmspage.bodyfield6 = params[:cms_page][:bodyfield6],
    cmspage.template_id = params[:cms_page][:template_id]

    pextra_fields = params[:extra_field] 
    if cmspage.extra_fields != nil && pextra_fields != nil && pextra_fields != ""
      cmspage.extra_fields.each do |efield|
        efvalue = nil
        pextra_fields.each do |pfield|
          if pfield.first.to_i == efield.id
           efvalue = pfield[1] 
          end
        end
        if efvalue != nil
         efield.field_value = efvalue
         efield.save
        else
         efield.destroy 
        end
      end
    end

    extraelemrnt =  params[:extraelemrnt]
   if extraelemrnt != nil && extraelemrnt != ""
      extraelemrnt.each do |element|
        if element != "" && element != t("CREATE_NEW_OBJECT_LABEL")
          ExtraField.create(:cms_page_id => cmspage.id, :field_name => element ).save
        end
      end 
   end

    # cmspage.save 
    respond_to do |format|
      if cmspage.save 
        #PagesGroup.updatepages(params)
          flash[:notice] = 'Page Updated Successfully!'
          format.html{ redirect_to :controller =>:admin, :action => :editpage, :cms_page_id => cmspage.id}
         else
          flash[:alert] = cmspage.errors
          format.html{ redirect_to :controller =>:admin, :action => :editpage, :cms_page_id => cmspage.id}
      end
    end
  end

#
#
#
def clonepage
cmspage = CmsPage.find(params[:page_id])
@cmspage = cmspage.clone
  respond_to do |format|
    format.html { render 'admin/CMS/newcmspage' }
  end
end

#
#
#
def exportcsv
  #require 'csv'
  @users = User.all

  attributes_to_include = %w(id email first_name last_name display_name avatar avatar_file_name avatar_updated_at)
  #attrs_to_csv = {:id,:email,:first_name, :last_name, :display_name,:avatar,:avatar_file_name,:avatar_updated_at}

  respond_to do |format|
   format.csv { send_data @users.to_csv(attributes_to_include)  }
   ##format.xls #{ send_data @users.to_csv(col_sep: "\t") }
   # format.html { render 'admin/test' }
  end
  
end


def  importusers
  if params[:file]
    User.importuser(params[:file])
    redirect_to root_url, notice: "User imported."  
  end
end

def exportxls
  @users = User.all
  @users.to_xls(:only => [:id, :email, :first_name, :last_name, :display_name, :avatar, :avatar_file_name, :avatar_updated_at])
end



def assign_survey_to_users
@survey = Survey.all
@grps = Group.all
end

def addexistingsurveys
  respond_to do |format|
    @errors = []
    @success = []
    @microsite = Microsite.find(params[:id])
    @Surveys = params[:Surveys]
    
    if params[:task] == "assign-survey-to-microsite"
      if @Surveys.size > 0
        @Surveys = @Surveys.first.split(",")
        @Surveys.each do |s|
          sdata = s.split(":")
          sid = sdata[1].to_i
          survey = nil
          if sid > 0
            survey = Survey.find_by(:id => sid)
          end
          if survey != nil
            if @microsite.surveys.exists?(survey.id)
              @errors << "Survey #{sdata[0]} al ready assigned to this microsite"
            else
             ms = MicrositesSurvey.new(:microsite_id => @microsite.id, :survey_id => survey.id )
             ms.save
             @success << "Survey #{sdata[0]} assigned successfully to microsite #{@microsite.title}"
            end
          else
          @errors << "Survey #{sdata[0]} Not Found In the system!"
          end
        end
      end
    end
    format.html{ render "admin/CMS/addexistingsurveys" }
  end
end

def unlinksurvey
  micrositesurvey = MicrositesSurvey.where(:microsite_id => params[:microsite_id], 
    :survey_id => params[:survey_id])
  if micrositesurvey != nil
    micrositesurvey.map{|ms| MicrositesSurvey.destroy(ms.id) }
  end
  respond_to do |format|
    format.html{ redirect_to "/microsites/#{params[:microsite_id]}/" }
  end
  
end
 

def sending_group_invitation_users
sid = params[:survery] 
allgrp = params[:interests] 
urlofsurvey = "take/survey/#{sid}"
# puts urlofsurvey 
all_users = Group.where('id IN (?)',allgrp)
users = []
all_users.each do | g1|
g1.users.each do |u|
  # users << u.email
  users.push([u.first_name, u.email])
end
end
users = users.uniq

begin
users.each do | k, v |
  InvitationMailer.sendsurveyinvitation(k,v,urlofsurvey).deliver
end
  flash[:notice] = "Survey invitations sent successfully"

rescue => e
  flash[:error] = "#{e.message}"
end
  redirect_to :back
# head :ok
end


def sendinvitationuser
  begin
    if params[:roleid].present?
    role = Role.find(params[:roleid])
    end
    params[:user_emails].split(",").each do |email|
    uu = User.invite!(:email => email)
    uu.roles<< role
  end
  
    flash[:notice] = "User invitations sent successfully"
rescue => e
  flash[:error] = "#{e.message}"
end
  redirect_to :back
end



def survey_exports
    id = params[:id]
    @survey = Survey.find(id)
    @sections = Section.where(survey_id: @survey.id).take(100) 
    @field_type = Question.field_type

    respond_to do |format|
      format.html
      format.csv 
      format.pdf do
        render pdf: "file_name",   # Excluding ".pdf" extension.
         template:  'admin/survey_exports.pdf.erb'
      end
    end
end

#
def accessmanage
  if params[:search]
    @users = User.search(params[:search]).order("created_at DESC")
  else
    @users = User.all.order('created_at DESC')
  end
end

#
def listClients
  @clients = Client.all
  respond_to do |format|
    format.html{ render "admin/clients/listClients" }
  end
end

#GET admin/clients/new 
def newclient
  @client = Client.new
  respond_to do |format|
    format.html{ render "admin/clients/new" }
  end
end

#PATCH admin/clients 
def createclient 
  @client = Client.new client_paramas
  
  respond_to do |format|
    if @client.save
      
      format.html{ redirect_to "/client/#{@client.id}", notice: 'Client was successfully created.' }
    else
      format.html{ render "admin/clients/new" }
    end
    
  end
end

def editclient
  @client = Client.find(params[:id])
  respond_to do |format|
    format.html{ render "admin/clients/edit" }
  end
end

def updateclient
  respond_to do |format|
    @client = Client.find(client_paramas[:id])
    if @client.update(client_paramas)
      format.html { redirect_to "/client/#{@client.id}", 
                          notice: 'Client was successfully updated.' }
    else
    format.html { render "admin/clients/edit" }                      
    end
    # format.html{ render "admin/clients/edit" }
  end
end

def showClient
  @client = Client.find(params[:id] ) 
 
  @groups = Group.all
  @errors = []
  @msitetoassign = nil
  if  @client != nil
    @microsites = @client.microsites.where(:publish  => true)
  end
  
    if params[:task] == "assign-microsites-to-client"
      @msites = params[:microsites]
      if @msites.to_s.size > 0
        @msitetoassign = @msites[0].split(",").map{|m| Microsite.find_by(:title =>m) != nil ? Microsite.find_by(:title =>m).id : @errors << "microsite #{m} not found in the system!"}
      end
      if @errors.size > 0
        return false   
      end  
      if @msitetoassign != nil
          @msitetoassign.each do |m|
            ms = Microsite.find(m)
            ms.client_id = @client.id
            ms.save
          end
      end  
    end
    respond_to do |format|
      format.html{ render "/admin/clients/showClient"}
    end
end

def microsites
  @client_id = params[:client_id]
  @client = Client.find(@client_id)
  @microsites = Microsite.where("client_id = NULL OR client_id = 0 OR client_id IS NULL")
  respond_to do |format|
    format.html{ render "admin/assign_microsites_to_client" }
  end
end

def assign_survey_to_microsite
    if params[:task].present? and params[:task] == "assign_survey_to_microsite"
     @microsite = Microsite.find(params[:microid])
     @survey = Survey.find(params[:surveyid])
  begin
  # puts @microsite.surveys.inspect
  # microsite.surveys.delete_all   #deleting existing roles from user
          @microsite.surveys << @survey
        
        respond_to do |format|
         msg = { :status => "ok", :message => "Survey assigned successfully", :html => "<b>Survey assigned successfully</b>" }
         format.json  { render :json => msg }
        end
  rescue Exception => e
    #puts "caught exception #{e}! ohnoes!"
  respond_to do |format|
    msg = { 
      :status => "ok", 
      :message => "caught exception #{e}! ohnoes!", 
      :html => "<b>caught exception #{e}! ohnoes!</b>" 
    }
  format.json  { render :json => msg }
  end
  end
  end
  if params[:task].present? and params[:task] == "unassignsurvey"
  @microsite = Microsite.find(params[:microid])
  @survey = Survey.find(params[:surveyid])
  begin
  # puts @microsite.surveys.inspect
   # microsite.surveys.delete_all   # deleting existing roles from user
    # @microsite.surveys >> @survey
  @microsite.surveys.delete(@survey)
  
  respond_to do |format|
   msg = { :status => "ok", :message => "Survey unassigned successfully", :html => "<b>Survey unassigned successfully</b>" }
   format.json  { render :json => msg }
  end
  rescue Exception => e
    #puts "caught exception #{e}! ohnoes!"
  respond_to do |format|
  msg = { :status => "ok", :message => "caught exception #{e}! ohnoes!", :html => "<b>caught exception #{e}! ohnoes!</b>" }
  format.json  { render :json => msg }
  end
  end
  end
end


private

  def check_permition
    if current_user != nil
      if !current_user.can? params[:action].to_sym, :admin
        flash[:alert] = [['You are not authorised to access this page']]
        redirect_to :controller => :admin, :action =>:home
      end
    end
  end

  def client_paramas
    params.require(:client).permit(:id,:name, :description, :logo, :status, :slug)
  end


  def user_params
     params.require(:user).permit(
            :first_name, 
            :last_name, 
            :display_name, 
            :username, 
            :email, 
            :status,
            :password,
            :admin)
  end


end
