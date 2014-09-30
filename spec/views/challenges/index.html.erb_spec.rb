require 'rails_helper'

RSpec.describe "challenges/index", :type => :view do
  before(:each) do
    assign(:challenges, [
      Challenge.create!(
        :name => "Name",
        :sender_id => 1,
        :recipient_id => 2,
        :post_id => 3,
        :state => "State",
        :notes => "MyText"
      ),
      Challenge.create!(
        :name => "Name",
        :sender_id => 1,
        :recipient_id => 2,
        :post_id => 3,
        :state => "State",
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of challenges" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
