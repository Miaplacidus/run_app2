class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.integer :gender
      t.string :email
      t.string :bday
      t.float :rating
      t.string :fbid
      t.string :img_url
      t.integer :level

      t.timestamps
    end
  end
end
