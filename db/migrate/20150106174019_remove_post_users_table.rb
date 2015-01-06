class RemovePostUsersTable < ActiveRecord::Migration
  def change
    drop_table(:post_users)
  end
end
