class TableausController < ApplicationController
  before_action :set_tableau, only: [:show, :edit, :update, :destroy]
  before_action :check_permition

  before_action :authenticate_user!
  protect_from_forgery with: :exception

  layout "dashboard"

  # GET /tableaus
  # GET /tableaus.json
  def index
    @tableaus = Tableau.all
  end

  # GET /tableaus/1
  # GET /tableaus/1.json
  def show
  end

  # GET /tableaus/new
  def new
    @tableau = Tableau.new
  end

  # GET /tableaus/1/edit
  def edit
  end

  # POST /tableaus
  # POST /tableaus.json
  def create
    @tableau = Tableau.new(tableau_params)

    respond_to do |format|
      if @tableau.save
        format.html { redirect_to @tableau, notice: 'Tableau was successfully created.' }
        format.json { render :show, status: :created, location: @tableau }
      else
        format.html { render :new }
        format.json { render json: @tableau.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tableaus/1
  # PATCH/PUT /tableaus/1.json
  def update
    respond_to do |format|
      if @tableau.update(tableau_params)
        format.html { redirect_to @tableau, notice: 'Tableau was successfully updated.' }
        format.json { render :show, status: :ok, location: @tableau }
      else
        format.html { render :edit }
        format.json { render json: @tableau.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tableaus/1
  # DELETE /tableaus/1.json
  def destroy
    @tableau.destroy
    respond_to do |format|
      format.html { redirect_to tableaus_url, notice: 'Tableau was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def check_permition
    if current_user != nil
      if !current_user.can? params[:action].to_sym, :tableau
      flash[:alert] = [['You are not authorised to access this page']]
      redirect_to :controller => :admin, :action =>:home
      end
    end 
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tableau
      @tableau = Tableau.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tableau_params
      params.require(:tableau).permit(:width, :height, :site_root, :tabs, :toolbar, :ticket, :load_order, :project_name, :project_title)
    end



end
