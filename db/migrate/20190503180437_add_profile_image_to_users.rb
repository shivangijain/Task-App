class AddProfileImageToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_attachment :users, :profile_image
  end
end
