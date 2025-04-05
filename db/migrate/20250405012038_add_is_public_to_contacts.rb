class AddIsPublicToContacts < ActiveRecord::Migration[8.0]
  def change
    add_column :contacts, :is_public, :boolean, default: false
    add_index :contacts, :is_public
  end
end
