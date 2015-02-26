require 'rails_helper'

RSpec.describe 'join_requests/index', type: :view do
  before(:each) do
    assign(:join_requests, [
      JoinRequest.create!(
        cicle_id: 1,
        user_id: 2,
        accepted: false
      ),
      JoinRequest.create!(
        cicle_id: 1,
        user_id: 2,
        accepted: false
      )
    ])
  end

  xit 'renders a list of join_requests' do
    render
    assert_select 'tr>td', text: 1.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
  end
end
