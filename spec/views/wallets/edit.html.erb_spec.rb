require 'rails_helper'

RSpec.describe 'wallets/edit', type: :view do
  before(:each) do
    @wallet = assign(:wallet, Wallet.create!(
      user_id: 1,
      balance: 1.5
    ))
  end

  it 'renders the edit wallet form' do
    render

    assert_select 'form[action=?][method=?]', wallet_path(@wallet), 'post' do

      assert_select 'input#wallet_user_id[name=?]', 'wallet[user_id]'

      assert_select 'input#wallet_balance[name=?]', 'wallet[balance]'
    end
  end
end
