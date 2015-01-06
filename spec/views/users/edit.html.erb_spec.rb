require 'rails_helper'

RSpec.describe "users/edit", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :first_name => "MyString",
      :gender => 1,
      :email => "MyString",
      :bday => "MyString",
      :rating => 1.5,
      :fbid => "MyString",
      :image => "MyString",
      :level => 1
    ))
  end

  xit "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_first_name[name=?]", "user[first_name]"

      assert_select "input#user_gender[name=?]", "user[gender]"

      assert_select "input#user_email[name=?]", "user[email]"

      assert_select "input#user_bday[name=?]", "user[bday]"

      assert_select "input#user_rating[name=?]", "user[rating]"

      assert_select "input#user_fbid[name=?]", "user[fbid]"

      assert_select "input#user_image[name=?]", "user[image]"

      assert_select "input#user_level[name=?]", "user[level]"
    end
  end
end
