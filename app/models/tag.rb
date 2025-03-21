class Tag < ApplicationRecord
  has_many :contact_tags
  has_many :contacts, through: :contact_tags

  validates :name, presence: true
end
