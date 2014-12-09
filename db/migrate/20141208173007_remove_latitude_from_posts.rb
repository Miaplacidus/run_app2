class RemoveLatitudeFromPosts < ActiveRecord::Migration
  def change
    remove_column("posts", "latitude")
  end
end
