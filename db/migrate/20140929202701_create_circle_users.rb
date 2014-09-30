class CreateCircleUsers < ActiveRecord::Migration
  def change
    create_table :circle_users do |t|
      t.integer :circle_id
      t.integer :user_id

      t.timestamps
    end

    add_index("circle_users", "circle_id")
    add_index("circle_users", "user_id")
  end
end
