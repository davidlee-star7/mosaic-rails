class User < ActiveRecord::Base
    devise  :database_authenticatable, :registerable,:confirmable, :invitable,
         :recoverable, :rememberable, :trackable, :validatable, :two_factor_authenticatable

    


  has_many :users_group
  has_many :groups, :through => :users_group

  after_create :send_email

  #attr_accessible :password, :confirm_password
  
  before_create :set_default_group
  def set_default_group
          self.groups ||= Group.find_by_name('All Users')
  end
  
  attr_accessor :custom_message

  has_many :file_mangers, :dependent => :delete_all
  has_many :folders, :dependent => :delete_all


  has_many :users_survey
  has_many :surveys, :through => :users_survey

  

  #has_many :microsites, :dependent => :destroy
  has_many :users_microsite
  has_many :microsites, :through => :users_microsite

  #has_many :microsites
  has_one_time_password
  has_many :surveys
  has_many :played_survey

  has_many :users_variables
  has_many :variables, through: :users_variables

  mount_uploader :avatar, AvatarUploader

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  has_attached_file :client_logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :client_logo, :content_type => /\Aimage\/.*\Z/

  def ability
    @ability ||=Ability.new(self)
  end
  delegate :can?, :canot?, :to => :ability
 
  validates :first_name, presence: true 
  #validates :email, uniqueness: true 
  #validates :email, uniqueness: true, presence: true 
  #validates :username, uniqueness: true 
  validates :username, presence: true, uniqueness: true  
   
 rolify

def self.user_fields(current_user)
      user_fields = { 
      'first_name' => 'First Name',
      'last_name' => 'Last Name',
      'display_name' => 'Display Name',
      'username' => 'User Name',
      'email' => 'Email',
      'status' => 'Status'
       }

       user = nil
       if (current_user!=nil)
        user = User.find(current_user)
       end

       if user!=nil
            if current_user.can? :create_admin, User
             user_fields['admin'] = 'Admin'
            end
       end

       user_fields['role'] = 'User Role'
       user_fields['password'] = 'Password'

      return user_fields
end  


def send_email
  InvitationMailer.creat_user_mail(self).deliver_now
end
 
  def has_group?(g)
    hasit = false
     self.groups.each do |group|
      if group.eql?g
        hasit = true
      end
     end  
    return hasit    
  end


  ####
  ####
  def update_groups(params)
    groups = params[:group]
    # first add newly selected groups
    # by checking if group is not already
    # added
    gids = []
    if groups != nil && groups.size > 0 
      groups.each do |g_id|
        g_id = g_id.first
        gids << g_id
        group = Group.find(g_id)
        if !self.has_group?(group)
          newgroup = UsersGroup.new
          newgroup.group_id = g_id
          newgroup.user_id = self.id
          newgroup.save
        end
        #test
      end
    end
    # now remove the groups unchecked by the user
    user_groups = Group.find(gids)
    all_groups = self.groups
    diff = all_groups - user_groups
    self.groups.destroy(diff)

    
  end


  ###############
  private 

  ####
  ####
  def self.encript_password(password)  
      papper = nil
      cost = 10
       
       encrypted_password = :: BCrypt::Password.create("#{password}#{papper}", :cost => cost).to_s

       return encrypted_password;
  end



def send_two_factor_authentication_code
puts ">>>>>>>>>>>>>>> otp_secret_key: #{otp_secret_key}, otp_code: #{otp_code}"
end
def need_two_factor_authentication?(request)
not otp_secret_key.nil?
end


  private

  def assign_role
  	self.add_role 'puser'
    serror = []

  end
#
# function to create 
# new user manually
#
  def self.addUser_ext(params)

      serror = []
      admin = false

      if params[:admin] == '1'
          admin = true
      end

      password = params[:password]
      @user = User.new(:first_name => params[:first_name],
      :last_name => params[:last_name],
      :display_name => params[:display_name],
      :email => params[:email],
      :username => params[:username],
      :status =>true,
      :admin => admin,
      :password =>password,
      :password_confirmation => password
      )
       # @user.skip_confirmation!
      #if params[:password].size < 9
      #serror[0] = 'Password is too short (minimum is 8 characters)'
      #end


      if @user.save == true

        if admin
          admin = Admin.new(:id =>@user.id)  
          admin.save    
        end
        
       uroles = params[:role] 
         if uroles!= nil
            uroles.each do |urole|
              puts @user.add_role(urole[1])
            end
         end

        return true;
      else
        return @user.errors
      end

  end
#
# function to update 
# existing user
#
  def self.update_ext(params)
    serror = []

    user = User.find_by(id:params[:user_id])
    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    user.display_name = params[:display_name]
    user.username = params[:username]
    user.email = params[:email]
    user.status = params[:status]

    if params[:admin] == '1'
      if user.admin != true
        user.admin = true
      end
    else
      user.admin = false
    end


    if params[:password].size > 0

      password = params[:password]
      encrypted_password = self.encript_password(password)
      user.encrypted_password = encrypted_password
      if params[:password].size < 9
      serror[0] = 'Password is too short (minimum is 8 characters)'
      end
    end

    if (user.valid? == false)
      return user
     else
      user.save

     roles = Role.listRoles
     # remove roles witch are not use has
     roles.each do |t1|  
        if params[:role]!= nil
            params[:role].each do |t2|

              if t1[0]!=t2[1]
               if(user.has_role? t1[0])  
                user.remove_role(t1[0])
               end
              end

            end   
        end   
     end
     # now add newly added roles
     if params[:role]!=nil
         params[:role].each do |t2|
             if(! user.has_role? t2[1] )
              user.add_role(t2[1])
             end
         end
     end   

     user.update_groups(params)

       return user

    end
  end

  # export csv
  #
  #
  def self.to_csv(attributes = column_names, options = {})
   # require 'csv'
    CSV.generate(options) do |csv|
      csv << attributes
      all.each do |user|
        csv << user.attributes.values_at(*attributes)
      end
    end

  end

  def self.importuser(file)
    CSV.foreach(file.path, headers: true) do |row|
# first_name,last_name,display_name,email,status,admin,password,password_confirmation,groups_name
groupsname = row.to_hash["group_name"]
# Rails.logger.warn row.to_hash.inspect
  user_hash = row.to_hash.except('group_name') # exclude the price field
  user = User.where(id: user_hash["id"])
  if user.count == 1
    user.first.update_attributes(user_hash)
  else
  hu =  User.invite!(user_hash)

  grp = Group.where(name: groupsname)
  if grp.count == 1
       hu.groups << grp
     else
    newgrp =  Group.create!(:name => groupsname)
    hu.groups << newgrp
     end
        # User.create!(user_hash)
      end # end if !product.nil?
    end # end CSV.foreach
  end # end self.import(file)
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


  


def self.search(query)
  where("email like (?) OR first_name like(?) OR last_name like (?) OR display_name like (?)", "%#{query}%","%#{query}%","%#{query}%","%#{query}%") 
end
 

end



