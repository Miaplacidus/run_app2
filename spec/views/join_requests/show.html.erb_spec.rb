require 'rails_helper'

RSpec.describe 'join_requests/show', type: :view do
  before(:each) do
    @join_request = assign(:join_request, JoinRequest.create!(
      cicle_id: 1,
      user_id: 2,
      accepted: false
    ))
  end

  xit 'renders attributes in <p>' do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
  end
end
