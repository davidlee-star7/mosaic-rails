class PagesGroupsController < ApplicationController
  before_action :set_pages_group, only: [:show, :edit, :update, :destroy]
  before_action :check_permition

  # GET /pages_groups
  # GET /pages_groups.json
  def index
    @pages_groups = PagesGroup.all
  end

  # GET /pages_groups/1
  # GET /pages_groups/1.json
  def show
  end

  # GET /pages_groups/new
  def new
    @pages_group = PagesGroup.new
  end

  # GET /pages_groups/1/edit
  def edit
  end

  # POST /pages_groups
  # POST /pages_groups.json
  def create
    @pages_group = PagesGroup.new(pages_group_params)
    respond_to do |format|
      if @pages_group.save
        format.html { redirect_to @pages_group, notice: 'Pages group was successfully created.' }
        format.json { render :show, status: :created, location: @pages_group }
      else
        format.html { render :new }
        format.json { render json: @pages_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages_groups/1
  # PATCH/PUT /pages_groups/1.json
  def update
    respond_to do |format|
      if @pages_group.update(pages_group_params)
        format.html { redirect_to @pages_group, notice: 'Pages group was successfully updated.' }
        format.json { render :show, status: :ok, location: @pages_group }
      else
        format.html { render :edit }
        format.json { render json: @pages_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages_groups/1
  # DELETE /pages_groups/1.json
  def destroy
    @pages_group.destroy
    respond_to do |format|
      format.html { redirect_to pages_groups_url, notice: 'Pages group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pages_group
      @pages_group = PagesGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pages_group_params
      params[:pages_group]
    end

  private
 
  def check_permition
    if current_user != nil
      if !current_user.can? params[:action].to_sym, :pagesgroup
      flash[:alert] = [['You are not authorised to access this page']]
      redirect_to :controller => :admin, :action =>:home
      end
    end 
  end  

end
