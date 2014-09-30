class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :post_id
      t.string :state, default: "pending"
      t.text :notes, default: ""

      t.timestamps
    end

    add_index("challenges", "post_id")
    add_index("challenges", "recipient_id")
    add_index("challenges", "sender_id")
  end
end
