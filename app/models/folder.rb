class Folder < ActiveRecord::Base
  has_many :file_mangers, :dependent => :destroy
    belongs_to :user
  end
