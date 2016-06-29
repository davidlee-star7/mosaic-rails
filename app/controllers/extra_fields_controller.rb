class ExtraFieldsController < ApplicationController
  before_action :set_extra_field, only: [:show, :edit, :update, :destroy]
  before_action :set_baclurl, only: [:show, :edit, :update]
  

  before_action :authenticate_user!
  before_action :check_permition
  protect_from_forgery with: :exception

   layout "dashboard"

  # GET /extra_fields
  # GET /extra_fields.json
  def index
    @extra_fields = ExtraField.all
  end

  # GET /extra_fields/1
  # GET /extra_fields/1.json
  def show
  end

  # GET /extra_fields/new
  def new
    @extra_field = ExtraField.new
  end

  # GET /extra_fields/1/edit
  def edit
    
  end

  # GET extra_fields/remove_by_grop  
  def remove_by_grop
      fields = ExtraField.all.where(:field_group => params[:group_id])
      fields.map{|f| f.destroy() }
      respond_to do |format|
        format.html{ render :html => "ok" }
      end
  end 

  # POST extra_fields/add_fields_by_group
  def add_fields_by_group
    lastid = ExtraField.last == nil ? 0 :  ExtraField.last.id
    fields = params[:extrafield]
    added_fields = []
    if fields != "" && fields != nil
      fields.each do |field|
         if field != "" && field != nil
           field_a = field.split(":")
           if field_a[0] != nil && field_a[1] != nil
             ef = ExtraField.create(
              :cms_page_id => params[:page_id] , 
              :field_name => params[:field_name], 
              :field_setting => field,
              :field_group => lastid)
             ef.save
             added_fields << ef
           end
         end
      end
    end

    respond_to do |format|
      format.json{ render json: added_fields, status: :ok }
      format.html{ render html: "ok", status: :ok }
    end
    
  end

  # POST /extra_fields
  # POST /extra_fields.json
  def create
    @extra_field = ExtraField.new(extra_field_params)

    respond_to do |format|
      if @extra_field.save
        format.html { redirect_to @extra_field, notice: 'Extra field was successfully created.' }
        format.json { render :show, status: :created, location: @extra_field }
      else
        format.html { render :new }
        format.json { render json: @extra_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extra_fields/1
  # PATCH/PUT /extra_fields/1.json
  def update
    respond_to do |format|
      if @extra_field.update(extra_field_params)
        format.html { redirect_to @extra_field, notice: 'Extra field was successfully updated.' }
        format.json { render :show, status: :ok, location: @extra_field }
      else
        format.html { render :edit }
        format.json { render json: @extra_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extra_fields/1
  # DELETE /extra_fields/1.json
  def destroy
    @extra_field.destroy
    respond_to do |format|
      format.html { redirect_to extra_fields_url, notice: 'Extra field was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extra_field
      @extra_field = ExtraField.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def extra_field_params
      params.require(:extra_field).permit(:cms_page_id, :field_name, :field_value, :field_setting, :back)
    end

  def check_permition
    if current_user != nil
      if !current_user.can? params[:action].to_sym, :extrafield
      flash[:alert] = [['You are not authorised to access this page']]
      redirect_to :controller => :admin, :action =>:home
      end
    end 
  end

  ###
  def set_baclurl
    @backurl = nil
    if params[:back] == "true"
      session[:edit_page_back] = true
    end
    if session[:edit_page_back] == true && session[:edit_page_last_id] != nil
      cms_page = CmsPage.find(session[:edit_page_last_id])
      if cms_page != nil
        @backurl = "/admin/editpage/#{cms_page.id}/?template_id=#{cms_page.template.id}"
      end
    end
  end
    
end
