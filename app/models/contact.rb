class Contact < ApplicationRecord
  belongs_to :user

  has_many :contact_tags, dependent: :destroy
  has_many :tags, through: :contact_tags

  mount_uploader :profile_image, ImageUploader

  validates :profile_image, file_size: { less_than_or_equal_to: 1000.kilobytes },
      file_content_type: { allow: [ "image/jpeg", "image/png" ] }
end
