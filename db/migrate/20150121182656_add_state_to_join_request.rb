class AddStateToJoinRequest < ActiveRecord::Migration
  def change
    add_column("join_requests", "state", :string, default: "pending")
  end
end
