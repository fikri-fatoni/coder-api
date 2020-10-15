class RenameImageToAvatarUser < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :image, :avatar
    rename_column :users, :name, :full_name
  end
end
