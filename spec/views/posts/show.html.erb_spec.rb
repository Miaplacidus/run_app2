require 'rails_helper'

RSpec.describe 'posts/show', type: :view do
  before(:each) do
    @post = assign(:post, Post.create!(
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
    ))
  end

  xit 'renders attributes in <p>' do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/Address/)
  end
end
