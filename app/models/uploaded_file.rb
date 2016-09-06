class UploadedFile < ActiveRecord::Base
  has_attached_file :file
  do_not_validate_attachment_file_type :file

  def remove_file
    file.destroy
    update_attributes!(
      file_file_name: nil,
      file_content_type: nil,
      file_file_size: nil,
      file_updated_at: nil
    )
  end
end
