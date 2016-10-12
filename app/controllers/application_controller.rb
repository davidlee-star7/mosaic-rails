class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_devise_params, if: :devise_controller?
  before_action :set_locale
  require 'json'

  rescue_from CanCan::AccessDenied do |exception|

      if current_user == nil
        redirect_to '/users/sign_in', :alert => exception.message
      else
        redirect_to '/page/show', :alert => exception.message
      end
      #if params[:action] == 'unauthorised'
      #end
  end



  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

   

	protected

	def configure_devise_params
       
	  registration_params = ['username', 'first_name','sir_name','last_name','display_name','status','activation_key','user_image','group_id','email','password','password_confirmation','avatar', 'avatar_cache']
	  if params[:action] == 'update' 
      devise_parameter_sanitizer.for(:account_update) { 
        |u| u.permit(registration_params << :current_password)
         
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) {  
        |u| u.permit(registration_params) 
      }
    end 

  end


  # def default_url_options(options={})
  #   logger.debug "default_url_options is passed options: #{options.inspect}\n"
  #   { :locale => I18n.locale }
  # end



  def after_sign_in_path_for(resource)
    #  if current_user
    #    puts "logged in"
    #   # redirect_to :controller => :admin, :action =>:home
    #   # redirect_to controller: 'admin', action: 'home'
    # else 
    #  puts "not logged -in"
    # end
    # redirect_to controller: 'admin', action: 'home'

    if current_user.admin
      redirect_path = admin_home_path(current_user.first_name)
    else
      group = current_user.groups.first
      puts group
      redirect_path = edit_user_registration_path
      if group.present?
        microsite = group.microsites.first
        puts microsite
        if microsite.present?
          redirect_path = client_microsite_path(microsite.client.slug, microsite.slug)
        end
      end
    end
    redirect_path
    # user_path(current_user) #your path
  end


end
