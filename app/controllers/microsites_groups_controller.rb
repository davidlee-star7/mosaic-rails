class MicrositesGroupsController < ApplicationController
  before_action :set_microsites_group, only: [:show, :edit, :update, :destroy]
  before_action :check_permition

  layout "dashboard"

  # GET /microsites_groups
  # GET /microsites_groups.json
  def index
    @microsites_groups = MicrositesGroup.all
  end

  # GET /microsites_groups/1
  # GET /microsites_groups/1.json
  def show
  end

  # GET /microsites_groups/new
  def new
    @microsites_group = MicrositesGroup.new
  end

  # GET /microsites_groups/1/edit
  def edit
  end

  # GET /microsites_groups/unlinkmicrosite/:microsite_id/:group_id
  def unlinkmicrosite
    microsites_group = MicrositesGroup.where(
      :microsite_id => params[:microsite_id],
      :group_id => params[:group_id]
      )

      if microsites_group != nil
        MicrositesGroup.destroy(microsites_group.map{ |mg| mg.id})
      end

      respond_to do |format|
        format.html{ redirect_to "/groups/#{params[:group_id]}" }
      end
  end

  #GET microsites_groups/listpagesbymicrositeandgroup
  def listpagesbymicrositeandgroup
    @group = Group.find(params[:group_id])
    @pages = CmsPage.where("id IN(?) AND microsite_id = (?)",
    @group.cms_pages.map{|p| p.id },params[:microsite_id])
    #, :group_id => params[:group_id],
    #:microsite_id => params[:microsite_id], :status => true
  end

  #GET microsites_groups/addexistingmicrositestogroups/:group_id
  def addexistingmicrositestogroups
    @group = Group.find(params[:group_id])
    @errors = []
    @success = []      

    if params[:task] == "assign-group-to-microsites"
       microsites = params[:microsites]  
       if microsites.size > 0
          microsites.first.split(",").each do |m|
            microsite = Microsite.find_by(:title => m)
            if microsite == nil
              @errors << "Microsite '#{m}' Not found in the System"
            else
              if(@group.microsites.exists?(microsite.id))
                @errors << "Microsite '#{microsite.title}' Already exists in this group"
              else
                mg = MicrositesGroup.new(:microsite_id => microsite.id,:group_id => @group.id )
                mg.save
                @success << "Microsite '#{microsite.title}' successfully added to group #{@group.name}"
              end
            end
          end    
       end     
    end

    @microsites = @group.microsites.size > 0 ? (Microsite.where("id NOT IN(?)",@group.microsites.map{|m| m.id})) : Microsite.all 
    @surveys = @group.surveys
  end


  # POST /microsites_groups
  # POST /microsites_groups.json
  def create
    @microsites_group = MicrositesGroup.new(microsites_group_params)
    respond_to do |format|
      if @microsites_group.save
        format.html { redirect_to @microsites_group, notice: 'Microsites group was successfully created.' }
        format.json { render :show, status: :created, location: @microsites_group }
      else
        format.html { render :new }
        format.json { render json: @microsites_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /microsites_groups/1
  # PATCH/PUT /microsites_groups/1.json
  def update
    respond_to do |format|
      if @microsites_group.update(microsites_group_params)
        format.html { redirect_to @microsites_group, notice: 'Microsites group was successfully updated.' }
        format.json { render :show, status: :ok, location: @microsites_group }
      else
        format.html { render :edit }
        format.json { render json: @microsites_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microsites_groups/1
  # DELETE /microsites_groups/1.json
  def destroy
    @microsites_group.destroy
    respond_to do |format|
      format.html { redirect_to microsites_groups_url, notice: 'Microsites group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_microsites_group
      @microsites_group = MicrositesGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def microsites_group_params
      params[:microsites_group]
    end

  def check_permition
    if current_user != nil
      if !current_user.can? params[:action].to_sym, :micrositegroup
      flash[:alert] = [['You are not authorised to access this page']]
      redirect_to :controller => :admin, :action =>:home
      end
    end 
  end    


end
