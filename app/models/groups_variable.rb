class GroupsVariable < ActiveRecord::Base
  validates :value, :presence => true
  validates_uniqueness_of :variable_id, :scope => :group_id

  belongs_to :group
  belongs_to :variable

  has_attached_file :value_file
  has_attached_file :value_image, styles: { medium: "300x300>", thumb: "50x50>" }, default_url: "/images/:style/missing.png"

  do_not_validate_attachment_file_type :value_file
  validates_attachment_content_type :value_image, content_type: /\Aimage\/.*\Z/
  
  def value
    retval = case variable.vtype
      when 'image'
        value_image
      when 'file'
        value_file
      else
        value_text
      end
    retval
  end
end
