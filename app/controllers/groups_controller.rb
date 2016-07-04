class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permition
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  # layout "admin"
  layout "dashboard"

 
  autocomplete :group, :name, :full => true
  autocomplete :user, :username,:full => true


  # GET /groups
  # GET /groups.json
  def index
   # @groups = Group.all
    #puts current_user.groups.inspect
    if current_user.admin
      @groups = Group.all
      @survey = Survey.all
    else
      @groups = current_user.groups
    end
  
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group_variables = @group.groups_variables
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # GET /groups/#{@group.id}/unlink_user/#{user.id}
  def unlink_user
    ug = UsersGroup.where(:user_id => params[:user_id], :group_id => params[:group_id] )
    if ug != nil
      ug.map{|t| UsersGroup.destroy(t.id)  }
    end
    respond_to do |format|
      format.html{ redirect_to "/groups/#{params[:group_id]}" }
    end
  end

  # POST group_addExistingUsers_path
  def addExistingUsers
    @group = Group.find(params[:group_id])
    @message = ''
    @users = []
    if params[:task] = "add_users_to_grop" && params[:users] != ""
      users = params[:users]
      if users != nil
        users.first.split(",").each do |u|
          user = User.where(:username => u, :status => true )
          if user != nil
            if !user.first.groups.exists?(@group.id)
              user.first.groups << @group
              @message = "#{user.first.username} successfully assigned to group #{@group.name}"
            else
              @message = "#{user.first.username} al ready exists in the group #{@group.name}"
            end
            
          end
        end
      end

      respond_to do |format|
        format.html { redirect_to @group, notice: @message }
        format.json { render json: user.first.groups, status: :created, notice: @message }
      end
    end
    
  end

  # GET group_addExistingUsers_path
  
  # def addExistingUsers
  #   @group = Group.find(params[:group_id])
  #   @errors = []
  #   @success = []
  #   @users = []
  #   if params[:task] = "add_users_to_grop" && params[:users] != ""
  #     users = params[:users]
  #     if users != nil
  #       users.first.split(",").each do |u|
  #         user = User.where(:username => u, :status => true )
  #         if user != nil
  #           if !user.first.groups.exists?(@group.id)
  #             user.first.groups << @group
  #             @success << "#{user.first.username} successfully assigned to group #{@group.name}" 
  #           else
  #             @errors << "#{user.first.username} al ready exists in the group #{@group.name}" 
  #           end
            
  #         end
  #       end
  #     end
  #   end
    
  # end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    respond_to do |format|
      if @group.save
        @group.users << current_user
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end


  # GET upload_users
  def upload_users
    @errors = []
    @success = []
    @dispatch = params[:csv_file]
    @group = Group.find(params[:group_id])
    count = 0
    if params[:task] == "Upload_users_csv"
    if @dispatch != nil && @dispatch.size

      CSV.foreach(@dispatch.path) do |row|
        if count > 0
           user = User.create(
                  :email => row[0], 
                  :password => row[1],
                  :username => row[2], 
                  :first_name => row[3], 
                  :sir_name => row[4], 
                  :last_name => row[5], 
                  :display_name => row[6], 
                  :status => true, 
                  :admin => false
                  ) 
           if user.errors.any?
             @errors << [user,user.errors.full_messages]
           else
            user.save
            @group.users << user
             @success << user
           end
           
        end
        count = count + 1        
      end
    else
      @errors << [nil,["Invalid File!"]]
    end
    end

   # dd

    @group = Group.find(params[:group_id])
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        # @group.users << current_user
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :description, :default_language)
    end

 
  def check_permition
    if current_user != nil
      if !current_user.can? params[:action].to_sym, :group
      flash[:alert] = [['You are not authorised to access this page']]
      redirect_to :controller => :admin, :action =>:home
      end
    end 
  end  

end
