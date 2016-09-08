class UsersVariablesController < ApplicationController
  before_action :set_users_variable, only: [:show, :edit, :update, :destroy]

  layout "dashboard"
  include VariablesHelper
  # GET /users_variables
  # GET /users_variables.json
  def index
    @user_variables = UsersVariable.all
  end

  # GET /users_variables/1
  # GET /users_variables/1.json
  def show
  end

  # GET /users_variables/new
  def new
    @user_variable = UsersVariable.new(user_id: params[:ext_user_id])
  end

  # GET /users_variables/1/edit
  def edit
  end

  # POST /users_variables
  # POST /users_variables.json
  def create
    @user_variable = UsersVariable.new(users_variable_params)

    respond_to do |format|
      begin
        if @user_variable.save
          format.html { redirect_to admin_editUser_path(@user_variable.user), notice: 'Groups variable was successfully created.' }
          format.json { render :show, status: :created, location: @user_variable }
        else
          format.html { render :new }
          format.json { render json: @user_variable.errors, status: :unprocessable_entity }
        end
      rescue
        format.html { render :new }
        format.json { render json: @user_variable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users_variables/1
  # PATCH/PUT /users_variables/1.json
  def update
    respond_to do |format|
      if @user_variable.update(users_variable_params)
        format.html { redirect_to admin_editUser_path(@user_variable.user), notice: 'Groups variable was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_variable }
      else
        format.html { render :edit }
        format.json { render json: @user_variable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users_variables/1
  # DELETE /users_variables/1.json
  def destroy
    @user_variable.destroy
    respond_to do |format|
      format.html { redirect_to admin_editUser_path(@user_variable.user), notice: 'Groups variable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_users_variable
      @user_variable = UsersVariable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def users_variable_params
      params.require(:users_variable).permit(:user_id, :variable_id, :value_text, :value_file, :value_image)
    end
end
