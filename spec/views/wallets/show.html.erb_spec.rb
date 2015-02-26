require 'rails_helper'

RSpec.describe 'wallets/show', type: :view do
  before(:each) do
    @wallet = assign(:wallet, Wallet.create!(
      user_id: 1,
      balance: 1.5
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/1.5/)
  end
end
