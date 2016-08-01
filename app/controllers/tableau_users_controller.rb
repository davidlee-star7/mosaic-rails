class TableauUsersController < ApplicationController
  before_action :set_tableau_user, only: [:show, :edit, :update, :destroy]

  layout "dashboard"

  # GET /tableau_users
  # GET /tableau_users.json
  def index
    @tableau_users = TableauUser.all
  end

  # GET /tableau_users/1
  # GET /tableau_users/1.json
  def show
  end

  # GET /tableau_users/new
  def new
    @tableau_user = TableauUser.new
  end

  # GET /tableau_users/1/edit
  def edit
  end

  # POST /tableau_users
  # POST /tableau_users.json
  def create
    @tableau_user = TableauUser.new(tableau_user_params)

    respond_to do |format|
      if @tableau_user.save
        format.html { redirect_to tableau_users_url, notice: t(:TABLEAU_USER_CREATE_SUCCESS) }
        format.json { render :show, status: :created, location: @tableau_user }
      else
        format.html { render :new }
        format.json { render json: @tableau_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tableau_users/1
  # PATCH/PUT /tableau_users/1.json
  def update
    respond_to do |format|
      if @tableau_user.update(tableau_user_params)
        format.html { redirect_to tableau_users_url, notice: t(:TABLEAU_USER_UPDATE_SUCCESS) }
        format.json { render :show, status: :ok, location: @tableau_user }
      else
        format.html { render :edit }
        format.json { render json: @tableau_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tableau_users/1
  # DELETE /tableau_users/1.json
  def destroy
    @tableau_user.destroy
    respond_to do |format|
      format.html { redirect_to tableau_users_url, notice: 'Tableau user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tableau_user
      @tableau_user = TableauUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tableau_user_params
      params.require(:tableau_user).permit(:username)
    end
end
