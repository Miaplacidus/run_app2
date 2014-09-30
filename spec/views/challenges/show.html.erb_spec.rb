require 'rails_helper'

RSpec.describe "challenges/show", :type => :view do
  before(:each) do
    @challenge = assign(:challenge, Challenge.create!(
      :name => "Name",
      :sender_id => 1,
      :recipient_id => 2,
      :post_id => 3,
      :state => "State",
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/MyText/)
  end
end
