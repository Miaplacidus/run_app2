class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :circle_id
      t.integer :creator_id
      t.datetime :time
      t.float :latitude
      t.float :longitude
      t.integer :pace
      t.text :notes, default: ""
      t.boolean :complete
      t.float :min_amt
      t.integer :age_pref
      t.integer :gender_pref
      t.integer :max_runners
      t.integer :min_distance
      t.string :address

      t.timestamps
    end

    add_index("posts", "creator_id")
    add_index("posts", "circle_id")
  end
end
