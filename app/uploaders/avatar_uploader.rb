class AvatarUploader < CarrierWave::Uploader::Base
  if Rails.env.test?
    storage :file

    # Stub out `url` in test to point to a known local file path
    def url(*args)
      "/test/fixtures/files/avatar.png"
    end
  else
    include Cloudinary::CarrierWave

    # Optional Cloudinary transformations
    version :thumb do
      process resize_to_fill: [ 200, 200 ]
    end
  end
end
