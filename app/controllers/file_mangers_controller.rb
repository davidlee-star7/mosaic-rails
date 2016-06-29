class FileMangersController < ApplicationController
 before_action :authenticate_user!
 before_action :check_permition
 before_action :set_file_manger, only: [:show, :edit, :update, :destroy]
 # layout "filesfolder"
  layout "dashboard"


  # GET /file_mangers
  # GET /file_mangers.json
  def index
   # @file_mangers = FileManger.where(:user_id=> current_user.id)

    ff = Folder.where(:user_id=> current_user.id)
    if ff.present?
      folder = Folder.find(params[:folder_id])
      @file_mangers = folder.file_mangers
    else
      flash[:notice] = 'Access Denied'
      redirect_to folders_path
    end

  end


  def all_files
    @files = FileManger.where(:user_id=> current_user.id)
  end


  def new_file
  @cc = Folder.where(:user_id=> current_user.id)

  end

   def create_file
  @newfile =   FileManger.create(:name => params[:name], :attachment=>params[:attachment],:folder_id=> params[:folder_id],:user_id => current_user.id)
    if @newfile.save
    flash[:notice] = 'File saved successfully'
    redirect_to folders_path
    else
    flash[:notice] = 'File not saved successfully'
    redirect_to folders_path
    end


  end


  # GET /file_mangers/1
  # GET /file_mangers/1.json
  def show
      folder = Folder.find(params[:folder_id])
      @file_manger = folder.file_mangers.find(params[:id])
  end

  # GET /file_mangers/new
  def new

    folder = Folder.find(params[:folder_id])
    #2nd you build a new one
    @file_manger = folder.file_mangers.build
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @file_manger }
    end
  end

  # GET /file_mangers/1/edit
  def edit
   folder = Folder.find(params[:folder_id])
   @file_manger = folder.file_mangers.find(params[:id])
  end

  # POST /file_mangers
  # POST /file_mangers.json
def create
    #1st you retrieve the post thanks to params[:post_id]
    folder = Folder.find(params[:folder_id])
    #2nd you create the comment with arguments in params[:comment]
    @file_manger = folder.file_mangers.create(file_manger_params)

    respond_to do |format|
      if @file_manger.save
        #1st argument of redirect_to is an array, in order to build the correct route to the nested resource comment
        format.html { redirect_to([@file_manger.folder, @file_manger], :notice => 'File was successfully created.') }
        #the key :location is associated to an array in order to build the correct route to the nested resource comment
        format.json  { render :json => @file_manger, :status => :created, :location => [@file_manger.folder, @file_manger] }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @file_manger.errors, :status => :unprocessable_entity }
      end
    end
end

  # PATCH/PUT /file_mangers/1
  # PATCH/PUT /file_mangers/1.json
  def update

         folder = Folder.find(params[:folder_id])
    #2nd you retrieve the comment thanks to params[:id]
      @file_manger = folder.file_mangers.find(params[:id])
       respond_to do |format|
      if @file_manger.update_attributes(file_manger_params)
        format.html { redirect_to([@file_manger.folder, @comment], :notice => 'File was successfully update.') }
        format.json  { render :json => @file_manger, :status => :created, :location => [@file_manger.folder, @file_manger] }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @file_manger.errors, :status => :unprocessable_entity }
      end
 end




  end

  # DELETE /file_mangers/1
  # DELETE /file_mangers/1.json
  def destroy
  
     #1st you retrieve the post thanks to params[:post_id]
    folder = Folder.find(params[:folder_id])
    #2nd you retrieve the comment thanks to params[:id]
    @file_manger = folder.file_mangers.find(params[:id])

# Rails.logger.warn @file_manger.inspect
    @file_mangers.destroy
    respond_to do |format|
      #1st argument reference the path /posts/:post_id/comments/
      format.html { redirect_to(folder_file_mangers_url) }
      format.json { head :no_content }
    end


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_file_manger
            #    folder = Folder.where(:id => params[:folder_id], :user_id => current_user.id)
            # if folder.present?
            # @file_mangers = folder.file_mangers.find(params[:id])
            # else
            # redirect_to folders_path
            # end



 ff = Folder.where(:user_id=> current_user.id)
    if ff.present?
      folder = Folder.find(params[:folder_id])
            @file_mangers = folder.file_mangers.find(params[:id])
    else
       flash[:notice] = 'Access Denied'
      redirect_to folders_path
    end




    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def file_manger_params
      #Rails.logger.warn params[:file_manger][:attachment].original_filename
      #Rails.logger.warn "test2"
      params.require(:file_manger).permit(:name, :size, :attachment,:folder_id).merge(:user_id => current_user.id)
      # .merge(:name=> params[:file_manger][:attachment].original_filename)
    end

   private  
  def check_permition
    if current_user != nil
      if !current_user.can? params[:action].to_sym, :filemanager
      flash[:alert] = [['You are not authorised to access this page']]
      redirect_to :controller => :admin, :action =>:home
      end
    end 
  end  
     
end
