class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.integer :user_id
      t.float :balance, default: 0.0

      t.timestamps
    end

    add_index('wallets', 'user_id')
  end
end
