class RemoveMaxMembersFromCircles < ActiveRecord::Migration
  def change
    remove_column("circles", "max_members")
  end
end
