class AddProfileImageToContacts < ActiveRecord::Migration[8.0]
  def change
    add_column :contacts, :profile_image, :string
  end
end
