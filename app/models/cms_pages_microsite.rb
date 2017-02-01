class CmsPagesMicrosite < ActiveRecord::Base
  belongs_to :cms_page
  belongs_to :microsite
  accepts_nested_attributes_for :microsite
end
