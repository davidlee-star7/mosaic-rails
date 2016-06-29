class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

 #before_filter :two_factor_authentication, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create

    super

  end

 

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end


  private

  def two_factor_authentication

#       Rails.logger.warn "test login"
# Rails.logger.warn params[:user]
# Rails.logger.warn params[:user][:email]

user = User.find_by(email:params[:user][:email])
if user.present?
flmsg = "Hi, We just sent you email. Please click on the link in email. thanks!"
OtpMailer.twofactor_email(user).deliver
else
flmsg = "We didn't recognize you. Please sign up first to proceed next"
end
#  Rails.logger.warn usersalreadysavedotp
# redirect_to ('/two_factor_authentication')
redirect_to new_user_session_path, :flash => { :success => flmsg }
  end
end
