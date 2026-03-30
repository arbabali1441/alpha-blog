class AddAvatarDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_data, :text
  end
end
