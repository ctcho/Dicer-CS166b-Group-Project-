class RemoveProfilePicPathFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :profile_pic_path, :string
  end
end
