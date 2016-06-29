namespace :otp_task do
  desc "rake task to update users with otp secret key"
	task :update_users_with_otp_secret_key  => :environment do
    users = User.all
    users.each do |user|
        key = ROTP::Base32.random_base32
        user.update_attributes(:otp_secret_key => key)
        user.save
        puts "Rake[:update_users_with_otp_secret_key] => User '#{user.email}' OTP secret key set to '#{key}'"
    end
end

end



# To run this task in terminal
# use following command
# First will show tasks in namespace
# Second will run particular task
# $ rake -T | grep otp_task
# rake otp_task:update_users_with_otp_secret_key 