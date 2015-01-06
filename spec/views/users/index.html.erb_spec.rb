require 'rails_helper'

RSpec.describe "users/index", :type => :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :first_name => "First Name",
        :gender => 1,
        :email => "Email",
        :bday => "Bday",
        :rating => 1.5,
        :fbid => "Fbid",
        :image => "Image",
        :level => 2
      ),
      User.create!(
        :first_name => "First Name",
        :gender => 1,
        :email => "Email",
        :bday => "Bday",
        :rating => 1.5,
        :fbid => "Fbid",
        :image => "Image",
        :level => 2
      )
    ])
  end

  xit "renders a list of users" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Bday".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Fbid".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
