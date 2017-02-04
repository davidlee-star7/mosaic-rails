class ExtraRow < ActiveRecord::Base
  validates :cms_page_id, presence: true
  has_many :extra_fields, :dependent => :destroy
  belongs_to :cms_page
end
