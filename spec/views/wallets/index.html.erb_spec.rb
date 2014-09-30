require 'rails_helper'

RSpec.describe "wallets/index", :type => :view do
  before(:each) do
    assign(:wallets, [
      Wallet.create!(
        :user_id => 1,
        :balance => 1.5
      ),
      Wallet.create!(
        :user_id => 1,
        :balance => 1.5
      )
    ])
  end

  it "renders a list of wallets" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
