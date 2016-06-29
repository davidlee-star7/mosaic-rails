class FileManger < ActiveRecord::Base
	 mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
  validates :attachment, presence: true # Make sure the owner's name is present.

  before_save :update_attachment_attributes

 belongs_to :folder
    belongs_to :user, :dependent => :destroy

  private

  def update_attachment_attributes
    if attachment.present? && attachment_changed?
      self.name = attachment.file.original_filename    
      self.size = attachment.file.size
    end
	end

end
