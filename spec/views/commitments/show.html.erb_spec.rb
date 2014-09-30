require 'rails_helper'

RSpec.describe "commitments/show", :type => :view do
  before(:each) do
    @commitment = assign(:commitment, Commitment.create!(
      :amount => 1.5,
      :fulfilled => false,
      :post_id => 1,
      :user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
