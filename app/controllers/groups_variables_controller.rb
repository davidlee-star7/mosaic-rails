class GroupsVariablesController < ApplicationController
  before_action :set_groups_variable, only: [:show, :edit, :update, :destroy]

  layout "dashboard"
  # GET /groups_variables
  # GET /groups_variables.json
  def index
    @group_variables = GroupsVariable.all
  end

  # GET /groups_variables/1
  # GET /groups_variables/1.json
  def show
  end

  # GET /groups_variables/new
  def new
    @group_variable = GroupsVariable.new(group_id: params[:group_id])
  end

  # GET /groups_variables/1/edit
  def edit
  end

  # POST /groups_variables
  # POST /groups_variables.json
  def create
    @group_variable = GroupsVariable.new(groups_variable_params)

    respond_to do |format|
      begin
        if @group_variable.save
          format.html { redirect_to @group_variable.group, notice: 'Groups variable was successfully created.' }
          format.json { render :show, status: :created, location: @group_variable }
        else
          format.html { render :new }
          format.json { render json: @group_variable.errors, status: :unprocessable_entity }
        end
      rescue
        format.html { render :new }
        format.json { render json: @group_variable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups_variables/1
  # PATCH/PUT /groups_variables/1.json
  def update
    respond_to do |format|
      if @group_variable.update(groups_variable_params)
        format.html { redirect_to @group_variable.group, notice: 'Groups variable was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_variable }
      else
        format.html { render :edit }
        format.json { render json: @group_variable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups_variables/1
  # DELETE /groups_variables/1.json
  def destroy
    @group_variable.destroy
    respond_to do |format|
      format.html { redirect_to @group_variable.group, notice: 'Groups variable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_groups_variable
      @group_variable = GroupsVariable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def groups_variable_params
      params.require(:groups_variable).permit(:group_id, :variable_id, :value_text, :value_file, :value_image)
    end
end
