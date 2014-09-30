require 'rails_helper'

RSpec.describe "circles/index", :type => :view do
  before(:each) do
    assign(:circles, [
      Circle.create!(
        :name => "Name",
        :max_members => 1,
        :latitude => 1.5,
        :longitude => 1.5,
        :description => "MyText",
        :level => 2,
        :city => "City",
        :admin_id => 3
      ),
      Circle.create!(
        :name => "Name",
        :max_members => 1,
        :latitude => 1.5,
        :longitude => 1.5,
        :description => "MyText",
        :level => 2,
        :city => "City",
        :admin_id => 3
      )
    ])
  end

  it "renders a list of circles" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
