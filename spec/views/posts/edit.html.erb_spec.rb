require 'rails_helper'

RSpec.describe "posts/edit", :type => :view do
  before(:each) do
    @post = assign(:post, Post.create!(
      :circle_id => 1,
      :creator_id => 1,
      :latitude => 1.5,
      :longitude => 1.5,
      :pace => 1,
      :notes => "MyText",
      :complete => false,
      :min_amt => 1.5,
      :age_pref => 1,
      :gender_pref => 1,
      :max_runners => 1,
      :min_distance => 1,
      :address => "MyString"
    ))
  end

  xit "renders the edit post form" do
    render

    assert_select "form[action=?][method=?]", post_path(@post), "post" do

      assert_select "input#post_circle_id[name=?]", "post[circle_id]"

      assert_select "input#post_creator_id[name=?]", "post[creator_id]"

      assert_select "input#post_latitude[name=?]", "post[latitude]"

      assert_select "input#post_longitude[name=?]", "post[longitude]"

      assert_select "input#post_pace[name=?]", "post[pace]"

      assert_select "textarea#post_notes[name=?]", "post[notes]"

      assert_select "input#post_complete[name=?]", "post[complete]"

      assert_select "input#post_min_amt[name=?]", "post[min_amt]"

      assert_select "input#post_age_pref[name=?]", "post[age_pref]"

      assert_select "input#post_gender_pref[name=?]", "post[gender_pref]"

      assert_select "input#post_max_runners[name=?]", "post[max_runners]"

      assert_select "input#post_min_distance[name=?]", "post[min_distance]"

      assert_select "input#post_address[name=?]", "post[address]"
    end
  end
end
