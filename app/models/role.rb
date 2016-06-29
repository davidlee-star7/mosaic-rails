class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true
  has_many :permitions, dependent: :destroy

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true


   def self.listRoles

   	all_rolles = Role.all
   	roles = []
   	all_rolles.each do |trole|
   		roles << [trole.name,trole.id]
   	end


   	return roles
   
   end   





  scopify
end
