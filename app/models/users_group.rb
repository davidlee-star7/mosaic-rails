class UsersGroup < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  validates :group_id, :user_id, presence: true
end
