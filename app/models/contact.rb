class Contact < ApplicationRecord
  belongs_to :user

  has_many :contact_tags, dependent: :destroy
  has_many :tags, through: :contact_tags

end
