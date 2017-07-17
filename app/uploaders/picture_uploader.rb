class PictureUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :fog unless Rails.env.test?

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Process files as they are uploaded:
  process resize_to_fit: [360, 360]

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [100, 100]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def content_type_whitelist
    /image\//
  end
end
