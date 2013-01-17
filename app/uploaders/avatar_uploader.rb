# encoding: utf-8

class AvatarUploader < BaseUploader


  DEFAULT_AVATAR_NAME = "default-avatar"

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    asset_path "#{DEFAULT_AVATAR_NAME}.png"
  end

  # Process files as they are uploaded:
  process resize_to_fill: [68, 66]

end
