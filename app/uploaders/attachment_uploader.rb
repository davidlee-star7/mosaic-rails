# encoding: utf-8
#require 'carrierwave/processing/mime_types'
class AttachmentUploader < CarrierWave::Uploader::Base
 #include CarrierWave::MimeTypes
  include ActionView::Helpers::NumberHelper
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog
  process :set_content_type
  process :save_content_type_and_size_in_model


  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir

        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"

   # "ckeditor_assets/pictures/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"

  #  "ckeditor_assets/pictures/#{model.id}"

    #{}"uploads/#{model.owner.id}/#{model.id}"
  end

 def save_content_type_and_size_in_model
# Rails.logger.warn "rbbs"
#   Rails.logger.warn number_to_human_size(file.size)
#   Rails.logger.warn "rbbsdfsds"
    model.name = file.original_filename if file.original_filename
    model.size = number_to_human_size(file.size)
     
  end

 

    def extension_white_list
    %w(pdf jpg png gif doc jpeg docx)
  end


  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end
  #   version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  #   version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

    # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

   def filename
    # model.id ? "#{model.id}-#{original_filename}" : original_filename
    "content_#{original_filename}" if original_filename
  end



  version :thumb do 
    def full_filename (for_file = model.attachment.file) 
     "thumb_#{original_filename}" if original_filename
    end 
  end 
  version :content do 
     def full_filename  (for_file = model.attachment.file) 
     "content_#{original_filename}" if original_filename
    end 
  end 

end
