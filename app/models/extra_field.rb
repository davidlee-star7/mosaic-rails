class ExtraField < ActiveRecord::Base
  validates :extra_row_id, presence: true
  belongs_to :extra_row
end
