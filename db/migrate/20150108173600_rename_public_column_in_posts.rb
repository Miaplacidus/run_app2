class RenamePublicColumnInPosts < ActiveRecord::Migration
  def change
    rename_column("posts", "public", "is_public")
  end
end
