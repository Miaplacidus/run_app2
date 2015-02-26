class CreateCommitments < ActiveRecord::Migration
  def change
    create_table :commitments do |t|
      t.float :amount
      t.boolean :fulfilled, default: false
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end

    add_index('commitments', 'post_id')
    add_index('commitments', 'user_id')
  end
end
