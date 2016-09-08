class UploadedFilesController < ApplicationController
  before_action :set_uploaded_file, only: [:show, :edit, :update, :destroy]

  layout "dashboard"

  # GET /uploaded_files
  # GET /uploaded_files.json
  def index
    @uploaded_files = UploadedFile.where.not(file_file_name: nil)

    orderby = 'file_file_name' if params[:orderby] == 'name'
    orderby = 'file_content_type' if params[:orderby] == 'type'
    orderby = 'file_updated_at' if params[:orderby] == 'date'
    if params[:orderby] == 'user_id'
      orderby = 'users.username' 
      @uploaded_files = @uploaded_files.includes(:user)
    end
    direction = params[:direction]
    direction = 'ASC' if direction != 'DESC' && direction != 'desc'
    
    if orderby.present?
      @uploaded_files = @uploaded_files.order("#{orderby} #{direction}")
    end
  end

  # GET /uploaded_files/1
  # GET /uploaded_files/1.json
  def show
  end

  # GET /uploaded_files/new
  def new
    @uploaded_file = UploadedFile.new
  end

  # GET /uploaded_files/1/edit
  def edit
  end

  # POST /uploaded_files
  # POST /uploaded_files.json
  def create
    @uploaded_file = UploadedFile.new(uploaded_file_params)

    respond_to do |format|
      if @uploaded_file.save
        format.html { redirect_to @uploaded_file, notice: 'Uploaded file was successfully created.' }
        format.json { render :show, status: :created, location: @uploaded_file }
      else
        format.html { render :new }
        format.json { render json: @uploaded_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uploaded_files/1
  # PATCH/PUT /uploaded_files/1.json
  def update
    respond_to do |format|
      if @uploaded_file.update(uploaded_file_params)
        format.html { redirect_to @uploaded_file, notice: 'Uploaded file was successfully updated.' }
        format.json { render :show, status: :ok, location: @uploaded_file }
      else
        format.html { render :edit }
        format.json { render json: @uploaded_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploaded_files/1
  # DELETE /uploaded_files/1.json
  def destroy
    # @uploaded_file.destroy
    @uploaded_file.remove_file
    respond_to do |format|
      format.html { redirect_to uploaded_files_url, notice: 'Uploaded file was successfully destroyed.' }
      format.json { head :no_content }
      format.js {}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uploaded_file
      @uploaded_file = UploadedFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def uploaded_file_params
      params.require(:uploaded_file).permit(:id, :file, :user_id)
    end
end
