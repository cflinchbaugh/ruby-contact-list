# Replace the 'config_from_url' string value below with your
# product environment's credentials, available from your Cloudinary console.
# =====================================================

require "cloudinary"

Cloudinary.config_from_url(ENV.fetch("CLOUDINARY_URL") { raise "CLOUDINARY_URL is not set!" })
