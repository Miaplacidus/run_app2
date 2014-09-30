require 'rails_helper'

RSpec.describe "commitments/index", :type => :view do
  before(:each) do
    assign(:commitments, [
      Commitment.create!(
        :amount => 1.5,
        :fulfilled => false,
        :post_id => 1,
        :user_id => 2
      ),
      Commitment.create!(
        :amount => 1.5,
        :fulfilled => false,
        :post_id => 1,
        :user_id => 2
      )
    ])
  end

  it "renders a list of commitments" do
    render
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
