class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  # Optional: Define any transformation you want
  version :thumb do
    process resize_to_fill: [ 200, 200 ]
  end
end
