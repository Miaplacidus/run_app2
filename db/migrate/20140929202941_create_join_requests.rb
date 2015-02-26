class CreateJoinRequests < ActiveRecord::Migration
  def change
    create_table :join_requests do |t|
      t.integer :circle_id
      t.integer :user_id
      t.boolean :accepted, default: false

      t.timestamps
    end

    add_index('join_requests', 'user_id')
    add_index('join_requests', 'circle_id')
  end
end
