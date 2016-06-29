class PlayedSurveysController < ApplicationController
 # before_action :set_played_survey, only: [:surveys, :survey, :savesurvey]
  before_action :authenticate_user!
  protect_from_forgery with: :exception
 layout "dashboard"
  # GET /played_surveys
  # GET /played_surveys.json
  def index
    @played_surveys = PlayedSurvey.all
  end

  # GET /played_surveys/1
  # GET /played_surveys/1.json
  def show
  end

  #
  #
  #
  def surveys

    @surveys = Survey.all.where("status = true")
    
  end

  #
  #
  #
  def survey
    @survey = Survey.find_by_id(params[:survey_id])
    @section = nil
      if @survey != nil
          if @survey.sections.size > 0 
              if params[:section_id] == '' || params[:section_id] == nil
                # inttially load first section
                @section = @survey.sections.first
              else
                @section = Section.find(params[:section_id])
              end
          else
            # empty survey
          end
      end
    # end survey function
  end

  ###
  def savesurvey
    @section = Section.find(params[:section_id])
    next_section = Section.next(params)
    params[:user_id] = current_user.id
    played_survey = @section.played_surveys.createNew(params)

        if played_survey == true
              if next_section != nil
                redirect_to '/take/survey/'+next_section.survey_id.to_s+'/'+next_section.id.to_s
              else
                flash[:notice] = 'Thanks for Submit The Survey.'
                redirect_to '/page/thanku/'
              end
        else
          flash[:alert] = played_survey
          redirect_to '/take/survey/'+@section.survey_id.to_s+'/'+@section.id.to_s
        end

  end



  # GET /played_surveys/new
  def new
    @played_survey = PlayedSurvey.new
  end

  # GET /played_surveys/1/edit
  def edit
  end

  # POST /played_surveys
  # POST /played_surveys.json
  def create
    @played_survey = PlayedSurvey.new(played_survey_params)

    respond_to do |format|
      if @played_survey.save
        format.html { redirect_to @played_survey, notice: 'Played survey was successfully created.' }
        format.json { render :show, status: :created, location: @played_survey }
      else
        format.html { render :new }
        format.json { render json: @played_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /played_surveys/1
  # PATCH/PUT /played_surveys/1.json
  def update
    respond_to do |format|
      if @played_survey.update(played_survey_params)
        format.html { redirect_to @played_survey, notice: 'Played survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @played_survey }
      else
        format.html { render :edit }
        format.json { render json: @played_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /played_surveys/1
  # DELETE /played_surveys/1.json
  def destroy
    @played_survey.destroy
    respond_to do |format|
      format.html { redirect_to played_surveys_url, notice: 'Played survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #
  #
  #
 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_played_survey
     # @played_survey = PlayedSurvey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def played_survey_params
      params.require(:played_survey).permit(:user_id, :section_id, :option)
    end
end
