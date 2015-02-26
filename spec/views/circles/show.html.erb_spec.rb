require 'rails_helper'

RSpec.describe 'circles/show', type: :view do
  before(:each) do
    @circle = assign(:circle, Circle.create!(
      name: 'Name',
      max_members: 1,
      latitude: 1.5,
      longitude: 1.5,
      description: 'MyText',
      level: 2,
      city: 'City',
      admin_id: 3
    ))
  end

  xit 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/3/)
  end
end
