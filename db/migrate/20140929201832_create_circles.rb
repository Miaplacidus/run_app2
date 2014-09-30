class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.string :name
      t.integer :max_members
      t.float :latitude
      t.float :longitude
      t.text :description
      t.integer :level
      t.string :city
      t.integer :admin_id

      t.timestamps
    end

    add_index("circles", "admin_id")
  end
end
