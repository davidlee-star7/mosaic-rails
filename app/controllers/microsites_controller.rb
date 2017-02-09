class MicrositesController < ApplicationController
   before_action :authenticate_user!
   # before_action :check_permition
   before_action :set_microsite, only: [:show, :edit, :update, :destroy, :addexistingpages, :unlinkcmspage]
   before_action :set_client, only: [:show, :edit, :update, :create]
   layout "dashboard"
  # GET /microsites
  # GET /microsites.json

  autocomplete :microsite, :title, :full => true, :scopes => ["filter_users"]
 
  def get_autocomplete_microsite_title
    term = params[:term]
    microsites = super(autocomplete_microsite_title)
  end

  def unlink_client
    @client = Client.find(params[:client_id])
    @microsite = Microsite.find(params[:microsite_id])

    if(@client.microsites.exists?(@microsite.id))
     @microsite.client_id = "NULL" 
     @microsite.save
    end
    redirect_to "/client/#{@client.id}"
  end

  def index 
      @groups = Group.all
      @surveys = Survey.all
      @roles = Role.listRoles
      @users = []
      @errors = []
      @success = ""

     if params[:search]
      @users = User.where(:status => true,:admin => false).search(params[:search]).order("created_at DESC")
      else
      @users = User.where(:status => true,:admin => false).order('created_at DESC')
     end

     if current_user.admin
      @microsites = Microsite.all
     else
      @microsites = current_user.microsites
     end

    if params[:task] == "microsite_to_group"
    
    groups = params[:groups]
    fgroups = []
    if groups.to_s.size > 0
      fgroups = groups[0].split(",").map{|gname| Group.find_by(:name => gname)!= nil ? Group.find_by(:name => gname).id : @errors << "#{gname} Not found in Groups." }
    end

    params[:groups] = fgroups

    microsites = params[:microsites]
    
    if groups.to_s.size < 1
      @errors << "You must select Group, from the list."
    end
    if microsites.to_s.size < 1
       @errors << "You must select Microsite."
    end
    if @errors.size > 0
      return;
    end
    @success = "Asssociation successed."
    microsites = microsites.split(",")
    groups.each do |g|
      microsites.each do |m|
        microsite = Microsite.find(m)
        if !microsite.groups.exists?(g)
          newmg = MicrositesGroup.new()
          newmg.microsite_id = m.to_i
          newmg.group_id = g.to_i 
          newmg.save
        end
      end
    end
   end
  end

  #GET microsites/:id/default_page
  def default_page
    @microsite = Microsite.find(params[:id])
    @pid = params[:pid]
    respond_to do |format|
      if @microsite == nil || @pid.to_i == 0
        format.html{ redirect_to "/microsites/#{@microsite.id}", notice: 'Error occured, please try again!' }
      else
        @microsite.cms_page_id = @pid.to_i
        if @microsite.save != true
         format.html{  redirect_to "/microsites/#{@microsite.id}", notice: 'Error occured, please edit and save, than try again!'}  
        else
        format.html{  redirect_to "/microsites/#{@microsite.id}", notice: 'Success!' }  
        end
       
      end
    end
  end

  # GET /microsites/1
  # GET /microsites/1.json
  def clientmicrosites
    #puts params
    head :ok
  end


  # GET /microsites/1
  # GET /microsites/1.json
  def show
  end

  # GET /microsites/new
  def new
    @microsite = Microsite.new
  end

  # GET /microsites/1/edit
  def edit
  end

  # POST /microsites
  # POST /microsites.json
  def create
    @microsite = Microsite.new(microsite_params)
    respond_to do |format|
      if @microsite.save    
        if current_user.id != microsite_params[:client_id]
         @microsite.users_microsite.create(:client_id => microsite_params[:client_id], :owner => true)
         @microsite.user_id = current_user.id
         @microsite.save
        end
        format.html { redirect_to "/microsites/#{@microsite.id}", notice: 'Microsite was successfully created.' }
        format.json { render :show, status: :created, location: @microsite }
      else
        format.html { render :new }
        format.json { render json: @microsite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /microsites/1
  # PATCH/PUT /microsites/1.json
  def update
    unless params[:clone].present?  and params[:clone] == "true"
      respond_to do |format|
        if @microsite.update(microsite_params)
             MicrositesGroup.updateMicrosite(params,@microsite)
             if @microsite.users.nil?
                @microsite.users << current_user
             end
            format.html { redirect_to "/microsites/#{@microsite.id}", 
                          notice: 'Microsite was successfully updated.' }
            format.json { render :show, status: :ok, location: @microsite.id }
        else
        format.html { render :edit }
        format.json { render json: @microsite.errors, status: :unprocessable_entity }
        end
      end  
    else
        @newmicro = @microsite.dup
        if @newmicro.title == params["microsite"]["title"]
            @newmicro.slug =  @newmicro.slug
        else
            @newmicro.title = params["microsite"]["title"]
            @newmicro.slug = params["microsite"]["title"].parameterize
        end

        respond_to do |format|
         if @newmicro.save
          @newmicro.users << current_user
          format.html { redirect_to microsites_path, notice: 'Microsite was successfully cloned.' }
          format.json { render :show, status: :created, location: @newmicro }
         else
          format.html { render :new }
          format.json { render json: @newmicro.errors, status: :unprocessable_entity }
         end
        end
    end      
         
  end

  # DELETE /microsites/1
  # DELETE /microsites/1.json
  def destroy
    @microsite.destroy
    respond_to do |format|
      format.html { redirect_to microsites_url, notice: 'Microsite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def addexistingpages
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
            @microsite.cms_pages << page unless @microsite.cms_pages.include?(page)
            @success << "CMS Page <i>#{p}</i> successfully added to Microsite <span>#{@microsite.title}</span>"
          end      
        end
      end
      respond_to do |format|
        format.html{ redirect_to "/microsites/#{@microsite.id}/" }
      end
    else
      respond_to do |format|
        format.html { render 'admin/CMS/addexistingpages' }
      end
    end
    
  end

  def unlinkcmspage
    page = CmsPage.find(params[:page_id])
    @microsite.cms_pages.delete(page)
    respond_to do |format|
      format.html{ redirect_to "/microsites/#{@microsite.id}/" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_microsite
    @microsite = Microsite.find(params[:id])
  end

  def set_client
  #  @client = Clien
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def microsite_params
      # params.require(:microsite).permit(:title, :default_language, :active_microsite, :description, :publish, :user_template, :layout_name, :client_logo, :background_color, :background_image, :font, :font_type, :user_id)
   params.require(:microsite).permit(:title, :default_language, :active_microsite, :description, :publish, :user_template, :layout_name, :client_logo, :background_color, :background_image, :remove_background_image, :font, :font_type, :template_id, :client_id, :slug)
  end

  
  def check_permition
    if current_user != nil
      if !current_user.can? params[:action].to_sym, :microsite
      flash[:alert] = [['You are not authorised to access this page']]
      redirect_to :controller => :admin, :action =>:home
      end
    end 
  end    

end
