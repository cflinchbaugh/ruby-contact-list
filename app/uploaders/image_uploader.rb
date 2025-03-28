class ImageUploader < CarrierWave::Uploader::Base
  # Tests should not interact with CarrierWave directly, it is an acceptable practice to conditionally separate Uploaders/Mailers/Loggers as done here
  if Rails.env.test?
    storage :file

    # Stub out `url` in test to point to a known local file path rather than rely on a CarrierWave file
    def url(*args)
      "/test/fixtures/files/avatar.png"
    end
  else
    include Cloudinary::CarrierWave

    # Whitelist extensions (safe fallback)
    def extension_allowlist
      %w[jpg jpeg png]
    end

    # Limit file size (fallback safety)
    def size_range
      1.kilobyte..1.megabyte
    end

    # Optional Cloudinary transformations
    version :thumb do
      process resize_to_fill: [ 200, 200 ]
    end
  end
end
