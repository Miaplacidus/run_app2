class RemoveAcceptedFromJoinRequest < ActiveRecord::Migration
  def change
    remove_column('join_requests', 'accepted')
  end
end
