class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contacts

  mount_uploader :avatar, ImageUploader
  validates :avatar, file_size: { less_than_or_equal_to: 1000.kilobytes },
      file_content_type: { allow: [ "image/jpeg", "image/png" ] }
end
