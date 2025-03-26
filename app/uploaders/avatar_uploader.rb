class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  if Rails.env.test?
    storage :file
  end

  # optional: skip versions in test
  if Rails.env.test?
    def thumb; end
  end

  # Optional: Define any transformation you want
  version :thumb do
    process resize_to_fill: [ 200, 200 ]
  end
end
