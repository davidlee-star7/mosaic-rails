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

  # GET extra_fields/remove_row  
  def remove_row
      row = ExtraRow.find(params[:group_id])
      row.destroy!
      respond_to do |format|
        format.html{ render :html => "ok" }
      end
  end 

  # POST extra_fields/add_row
  def add_row
    lastid = ExtraField.last == nil ? 0 :  ExtraField.last.id
    fields = params[:extrafield]
    added_fields = []
    page = CmsPage.find(params[:page_id])
    if page.present? && fields != "" && fields != nil
      pos = page.extra_rows.count() + 1
      @row = ExtraRow.create(row_name: params[:field_name], position: pos)
      page.extra_rows << @row

      fields.each do |field|
        if field != "" && field != nil
          field_a = field.split(":")
          if field_a[0] != nil && field_a[1] != nil
            ef = ExtraField.create(:field_setting => field)
            @row.extra_fields << ef
            added_fields << ef
          end
        end
      end

      respond_to do |format|
        format.json{ render json: added_fields, status: :ok }
        format.html{ render 'admin/CMS/add_extra_row' }
      end
    else
      respond_to do |format|
        format.json{ render json: {status: 'fail'}, status: :unprocessable_entity }
        format.html{ render html: "fail", status: :unprocessable_entity }
      end
    end    
  end

  def order_row
    row_order = params[:row_order]
    row_order.each_with_index do |row_id, index|
      ExtraRow.find(row_id).update(position: index + 1)
    end
    respond_to do |format|
      format.json{ render json: row_order, status: :ok }
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
