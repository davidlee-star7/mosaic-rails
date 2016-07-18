class Variable < ActiveRecord::Base
  Types = {
    'tableau_url_appendage' => 'Tableau URL Appendage',
    'text' => 'Text',
    'code' => 'Code',
    'image' => 'Image',
    'file' => 'File'
  }

  validates :name, :presence => true, :uniqueness => true
  validates :identifier, :presence => true, :uniqueness => true

  has_many :groups_variables, :dependent => :destroy
  has_many :groups, through: :groups_variables, :dependent => :destroy

  has_many :users_variables, :dependent => :destroy
  has_many :users, through: :users_variables, :dependent => :destroy
end
