class QfieldsController < ApplicationController
  before_action :set_qfield, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  

  # GET /qfields
  # GET /qfields.json
  def index
    @qfields = Qfield.all
  end

  # GET /qfields/1
  # GET /qfields/1.json
  def show
  end

  # GET /qfields/new
  def new
    @qfield = Qfield.new
  end

  # GET /qfields/1/edit
  def edit
  end

  # POST /qfields
  # POST /qfields.json
  def create
    @qfield = Qfield.new(qfield_params)

    respond_to do |format|
      if @qfield.save
        format.html { redirect_to @qfield, notice: 'Qfield was successfully created.' }
        format.json { render :show, status: :created, location: @qfield }
      else
        format.html { render :new }
        format.json { render json: @qfield.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /qfields/1
  # PATCH/PUT /qfields/1.json
  def update
    respond_to do |format|
      if @qfield.update(qfield_params)
        format.html { redirect_to @qfield, notice: 'Qfield was successfully updated.' }
        format.json { render :show, status: :ok, location: @qfield }
      else
        format.html { render :edit }
        format.json { render json: @qfield.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qfields/1
  # DELETE /qfields/1.json
  def destroy
    @qfield.destroy
    respond_to do |format|
      #format.html { redirect_to qfields_url, notice: 'Qfield was successfully destroyed.' }
      format.json { render json:{ :delete => 1 } }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qfield
      @qfield = Qfield.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qfield_params
      params.require(:qfield).permit(:fval, :type_id, :section_id)
    end
end
