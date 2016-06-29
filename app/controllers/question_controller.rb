class QuestionController < ApplicationController

	before_action :authenticate_user!
	protect_from_forgery with: :exception


	def new
		@field_type = Question.field_type
		@question = nil
		@section = Section.find(params[:section_id])
		respond_to do |format|

			format.html { render :'question/_new'}

		end
			
	end	

  def field_type
  	# question_id is only used to handle
  	# edit question request
  	@field_type = Question.field_type

  	ftype = params[:ftype]

  	@question = nil


  	if params[:question_id] != nil && params[:question_id]!='' && params[:question_id].size > 0

  		question_id = params[:question_id].to_i

  		@question = Question.find(question_id)
  		
  	end



  	respond_to do |format|
      if ftype=='1'
        format.html { render :'question/fields/_f1'}
      elsif ftype=='2' 
        format.html { render :'question/fields/_f2'}
      elsif ftype == '3'
      	format.html { render :'question/fields/_f3'}
      elsif ftype == '4'
      	format.html { render :'question/fields/_f4'}
      elsif ftype == '5'
      	format.html { render :'question/fields/_f5'}
      elsif ftype == '6'
      	format.html { render :'question/fields/_f6'}
      elsif ftype == '7'
      	format.html { render :'question/fields/_f7'}
      elsif ftype == '8'
      	format.html { render :'question/fields/_f8'}	  	
        #format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :'question/fields/_f1' }
        #format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end



  end

def create
	question = Question.new(
		:section_id =>params[:section_id],
		:title => params[:title],
		:field_type => params[:qtype],
		:status => true,
		:additional_instruction_text => params[:additional_instruction_text],
		:default_answer => params[:default_answer],
		:weight => params[:weight],
		:allow_comments => params[:allow_comments]
		)

	section = Section.find(params[:section_id])

		respond_to do |format|
			if question.save

				question.qfields.addfields(params)

				if params[:qtype] == '2'

					question.qhfields.addfields(params)
						
				end	
				
				flash[:notice] = "Question Successfully created!"
				else
				flash[:alert] = question.errors	
			end

	 	format.html { redirect_to :controller => :admin, :action =>:buildsurvey, 
	 			:id =>section.survey_id 
	 			}

	#format.html{ render 'admin/test' }
		end	
end


def update
	question = Question.find(params[:question_id])

		question.title = params[:title]
		question.field_type = params[:qtype]
		question.additional_instruction_text = params[:additional_instruction_text]
		question.default_answer = params[:default_answer]
		question.weight = params[:weight]
		question.allow_comments = params[:allow_comments]
		#question.save

		if question.save
			question.qfields.updatefields(params)
			question.qhfields.updatefields(params)

		end

	# now update to fields 

	respond_to do |format|

		format.html {
		redirect_to :controller => :admin, :action =>:buildsurvey, 
				:id =>params[:survey_id] 
		 }

	end
end

#
#
#
def edit
	@field_type = Question.field_type
	@question = Question.find(params[:id])
	@survey = Survey.find(params[:survey_id])

  	respond_to do |format|
  		 
  		  format.html { render :'question/edit' }
  		 
		# format.html { render :'question/fields/_f' } 
    end

end

#
#
#
def delete
question = Question.find(params[:id])
question.destroy
	respond_to do |format|
		format.html { redirect_to :controller => :admin, :action =>:buildsurvey, 
				:id =>params[:survey_id] 
				}
	end

end

end
