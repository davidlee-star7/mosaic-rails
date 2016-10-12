class Group < ActiveRecord::Base

  has_many :users_group
  has_many :users, :through => :users_group

  has_many :survey_groups
  has_many :surveys, :through => :survey_groups

  has_many :pages_groups
  has_many :cms_pages, :through => :pages_groups

  has_many :microsites_group
  has_many :microsites, :through => :microsites_group

  validates :name, presence: true
  validates :name, format: { with: /\A[a-zA-Z0-9 _-]+\z/,
    message: "You can only use A-Z, a-z, 0-9, -, _ latters for group name." }
  validates :name, length: { minimum: 2 }
  validates :name, length: { maximum: 50 }  
  validates :name, uniqueness: true
  
  has_many :groups_variables
  has_many :variables, through: :groups_variables
end
