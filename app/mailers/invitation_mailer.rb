class InvitationMailer < ApplicationMailer
default from: "info@mosaica.com"
def sendsurveyinvitation(uname,uemail,urlofsurvey) 
	@uname = uname
	@uemail = uemail
	@urlofsurvey = urlofsurvey
    mail(to: @uemail, subject: 'You have an invitation of survey')

end

def creat_user_mail user
	 @user = user	
	# mail(to: user.email, subject: 'Your created at Mosasica site')
end

end
