class OtpMailer < ApplicationMailer
	# default from: "from@example.com"
	default from: "info@mosaica.com"

	 def twofactor_email(user)
	 	Rails.logger.warn "you are in email"
    @user = user


if @user.otp_secret_key.blank?
 key = ROTP::Base32.random_base32
  @user.update_attributes(:otp_secret_key => key)
	end

    # key = ROTP::Base32.random_base32
    #     @user.update_attributes(:otp_secret_key => key)


    mail(to: @user.email, subject: 'Confirmation Email')
  end



end
