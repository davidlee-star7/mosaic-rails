class SurveysController < ApplicationController
  layout "dashboard"
  before_action :set_survey, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :check_permition

  autocomplete :survey, :name, :full => true, 
  :column_name => 'name', :display_value => 'show_slug',
  :scopes => [:unassigned_survey]
  #:extra_data => [:slug,:microsite_id], :column_name => 'slug',
  #:scopes => [:unassigned_pages]

  #
  #
  #
  def check_permition
    if current_user != nil
      if !current_user.can? params[:action].to_sym, :surveys
      flash[:alert] = [['You are not authorised to access this page']]
       redirect_to :controller => :admin, :action =>:home
      end
    end
  end
  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.all
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(survey_params)

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: 'Survey was successfully created.' }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update

    @survey = Survey.find(params[:id])
    @survey.name = params[:name]
    @survey.name = params[:name]
    @survey.name = params[:name]
    @survey.thank_page_title = params[:thank_page_title]
    @survey.thank_page_description = params[:thank_page_description]

    respond_to do |format|
      if @survey.save
        format.html { redirect_to controller: 'admin', action: 'editsurvey', id: @survey.id, notice: 'Survey was successfully Update.' }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { redirect_to controller: 'admin', action: 'editsurvey', id: @survey.id, notice: 'Errors' }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to controller: 'admin', action: 'manageSurvey', notice: 'Survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #
  #
  #
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
    # params.require(:survey).permit(:name, :description, :status, :user_id)
    end


end
