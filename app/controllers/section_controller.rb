class SectionController < ApplicationController


  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :check_permition


  #
  #
  #
  def check_permition
    if current_user != nil
          if !current_user.can? params[:action].to_sym, :section
          flash[:alert] = [['You are not authorised to access this page']]
           redirect_to :controller => :admin, :action =>:home
          end
    end
  end

  #
  #
  #
  def edit
  	@section = Section.find(params[:id])
  end
  #
  #
  #
  def update
  	section = Section.find(params[:section_id])
  	section.title = params[:title]
  	section.description = params[:description]
  	section.save
  	redirect_to :controller => :admin, :action =>:buildsurvey, id: params[:id]
  end

  #
  # 
  #
  def new
  	@survey_id = params[:id]
  	if !@survey_id
  		return false
  	end

  end

 #
 # create
 #
 def create
 	@survey_id = params[:id]

 	if @survey_id

 		@section = Section.new(
 			:title => params[:title],
 			:description => params[:description],
 			:survey_id => @survey_id,
      :status => true
 			)

	 	respond_to do |format|
	      if @section.save
	      	flash[:notice] = "Section Successfully created!"
	        format.html { redirect_to :controller => :admin, :action =>:buildsurvey, 
 			id: @survey_id }
	        #format.json { render :show, status: :created, location: @survey }
	      else
	      	alert
	      	flash[:alert] = @section.errors
	        format.html { 
	        	redirect_to :controller => :admin, :action =>:buildsurvey, 
 			id: @survey_id, :notice => true }
	        #format.json { render json: @survey.errors, status: :unprocessable_entity }
	      end
	   end
   
 	end
 end

 def delete
  section = Section.find(params[:id])
  survey_id = section.survey_id
  section.destroy
  flash[:notice] = "Section Deleted Successfully!"
  redirect_to :controller => :admin, :action =>:buildsurvey, id: survey_id
 end



end
