class VariablesController < ApplicationController
  before_action :set_variable, only: [:show, :edit, :update, :destroy]

  layout "dashboard"
  # GET /variables
  # GET /variables.json
  def index
    @variables = Variable.all
  end

  # GET /variables/1
  # GET /variables/1.json
  def show
    @vtype_names = Variable::Types
  end

  # GET /variables/new
  def new
    @variable = Variable.new
  end

  # GET /variables/1/edit
  def edit
  end

  # POST /variables
  # POST /variables.json
  def create
    @variable = Variable.new(variable_params)

    respond_to do |format|
      begin
        if @variable.save
          format.html { redirect_to variables_url, notice: t(:VARIABLE_CREATE_SUCCESS) }
          format.json { render :show, status: :created, location: @variable }
        else
          format.html { render :new }
          format.json { render json: @variable.errors, status: :unprocessable_entity }
        end
      rescue ActiveRecord::RecordInvalid => e
        format.html { render :new }
        format.json { render json: @variable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /variables/1
  # PATCH/PUT /variables/1.json
  def update
    respond_to do |format|
      if @variable.update(variable_params)
        format.html { redirect_to variables_url, notice: t(:VARIABLE_UPDATE_SUCCESS) }
        format.json { render :show, status: :ok, location: @variable }
      else
        format.html { render :edit }
        format.json { render json: @variable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /variables/1
  # DELETE /variables/1.json
  def destroy
    @variable.destroy
    respond_to do |format|
      format.html { redirect_to variables_url, notice: 'Variable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_variable
      @variable = Variable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def variable_params
      params.require(:variable).permit(:name, :vtype, :identifier)
    end
end
