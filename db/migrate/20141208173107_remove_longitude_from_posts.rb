class RemoveLongitudeFromPosts < ActiveRecord::Migration
  def change
    remove_column('posts', 'longitude')
  end
end
