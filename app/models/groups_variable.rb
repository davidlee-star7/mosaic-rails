class GroupsVariable < ActiveRecord::Base
  validates :value, :presence => true
  validates_uniqueness_of :variable_id, :scope => :group_id

  belongs_to :group
  belongs_to :variable
end
