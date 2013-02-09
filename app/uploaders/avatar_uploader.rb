# encoding: utf-8

class AvatarUploader < BaseUploader
  DEFAULT_AVATAR_NAME = "default-avatar"

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    asset_path "#{DEFAULT_AVATAR_NAME}.png"
  end

  def filename
    ivar = "@#{mounted_as}_token"
    timestamp = model.instance_variable_get(ivar)
    timestamp ||= model.instance_variable_set(ivar, DateTime.now)
    extension = model.avatar.file.extension if model.avatar.file.present?
    extension = 'jpg' if extension.blank?
    "original.#{timestamp.to_i}.#{extension}" if original_filename
  end

  # Process files as they are uploaded:
  version :thumb do
    process resize_to_fill: [68, 68]
  end

end
