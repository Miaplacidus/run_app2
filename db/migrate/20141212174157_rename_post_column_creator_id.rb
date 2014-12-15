class RenamePostColumnCreatorId < ActiveRecord::Migration
  def change
    rename_column("posts", "creator_id", "organizer_id")
  end
end
