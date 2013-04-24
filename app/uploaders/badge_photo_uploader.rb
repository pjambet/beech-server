# encoding: utf-8

class BadgePhotoUploader < BaseUploader

  DEFAULT_BADGE_NAME = 'default-badge'

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))

    # "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    asset_path "#{[version_name, DEFAULT_BADGE_NAME].compact.join('_')}.png"
  end

  process resize_to_fill: [200, 200]

  version :thumb do
    process resize_to_fill: [100, 100]
  end
end

