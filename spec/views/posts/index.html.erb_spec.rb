require 'rails_helper'

RSpec.describe 'posts/index', type: :view do
  before(:each) do
    assign(:posts, [
      Post.create!(
        circle_id: 1,
        creator_id: 2,
        latitude: 1.5,
        longitude: 1.5,
        pace: 3,
        notes: 'MyText',
        complete: false,
        min_amt: 1.5,
        age_pref: 4,
        gender_pref: 5,
        max_runners: 6,
        min_distance: 7,
        address: 'Address'
      ),
      Post.create!(
        circle_id: 1,
        creator_id: 2,
        latitude: 1.5,
        longitude: 1.5,
        pace: 3,
        notes: 'MyText',
        complete: false,
        min_amt: 1.5,
        age_pref: 4,
        gender_pref: 5,
        max_runners: 6,
        min_distance: 7,
        address: 'Address'
      )
    ])
  end

  xit 'renders a list of posts' do
    render
    assert_select 'tr>td', text: 1.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 1.5.to_s, count: 2
    assert_select 'tr>td', text: 1.5.to_s, count: 2
    assert_select 'tr>td', text: 3.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
    assert_select 'tr>td', text: 1.5.to_s, count: 2
    assert_select 'tr>td', text: 4.to_s, count: 2
    assert_select 'tr>td', text: 5.to_s, count: 2
    assert_select 'tr>td', text: 6.to_s, count: 2
    assert_select 'tr>td', text: 7.to_s, count: 2
    assert_select 'tr>td', text: 'Address'.to_s, count: 2
  end
end
