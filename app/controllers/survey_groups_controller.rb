class SurveyGroupsController < ApplicationController
  before_action :set_survey_group, only: [:show, :edit, :update, :destroy]

   layout "dashboard"
  # GET /survey_groups
  # GET /survey_groups.json
  def index
    @survey_groups = SurveyGroup.all
  end

  # GET /survey_groups/1
  # GET /survey_groups/1.json
  def show
  end

  # GET /survey_groups/new
  def new
    @survey_group = SurveyGroup.new
  end

  # GET /survey_groups/1/edit
  def edit
  end

  # POST /survey_groups
  # POST /survey_groups.json
  def create
    @survey_group = SurveyGroup.new(survey_group_params)
    respond_to do |format|
      if @survey_group.save
        format.html { redirect_to @survey_group, notice: 'Survey group was successfully created.' }
        format.json { render :show, status: :created, location: @survey_group }
      else
        format.html { render :new }
        format.json { render json: @survey_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /survey_groups/1
  # PATCH/PUT /survey_groups/1.json
  def update
    respond_to do |format|
      if @survey_group.update(survey_group_params)
        format.html { redirect_to @survey_group, notice: 'Survey group was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey_group }
      else
        format.html { render :edit }
        format.json { render json: @survey_group.errors, status: :unprocessable_entity }
      end
    end
  end

  #GET survey_groups/addexistingsurveystogroups/:group_id
  def addexistingsurveystogroups
    @group = Group.find(params[:group_id])
    @errors = []
    @success = [] 
    if params[:task] == "assign-group-to-surveys"
      surveys = params[:surveys]
      if surveys.size > 0
        surveys.first.split(",").each do |s|
          s = s.split(":")
          name = s[0]
          id = s[1].to_i
          survey = Survey.exists?(id) ?  Survey.find(id) : nil
          if survey  != nil
            if @group.surveys.exists?(id)
              @errors << "Survey '#{name}' Already exists in this group"
            else
              if @group.survey_groups.create(:survey_id => id).save
                @success << "Survey '#{name}' successfully added to group #{@group.name}"
                else
                @errors << "Survey '#{name}' Can Not be added to group #{@group.name}, due to unknown error"
              end
            end
          else
             @errors << "Survey '#{name}' Not found in the System"
          end
        end
      end
       
    end
    @surveys = @group.surveys.size == 0 ? Survey.all.where(:status => true) : Survey.all.where("id NOT IN (?) AND status=true", @group.surveys.map{|s| s.id})
  end


  ##
  def unlinkgroup
    survey_group = SurveyGroup.where(
      :survey_id => params[:survey_id], 
      :group_id => params[:group_id])

    if survey_group != nil
      survey_group.map{|sg| SurveyGroup.destroy(sg.id)  }
    end

    respond_to do |format|
      format.html{ redirect_to "/groups/#{params[:group_id]}" }
    end
    
  end

  # DELETE /survey_groups/1
  # DELETE /survey_groups/1.json
  def destroy
    @survey_group.destroy
    respond_to do |format|
      format.html { redirect_to survey_groups_url, notice: 'Survey group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey_group
      @survey_group = SurveyGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_group_params
      params.require(:survey_group).permit(:survey_id, :group_id)
    end
end
