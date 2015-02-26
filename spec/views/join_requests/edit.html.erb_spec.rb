require 'rails_helper'

RSpec.describe 'join_requests/edit', type: :view do
  before(:each) do
    @join_request = assign(:join_request, JoinRequest.create!(
      cicle_id: 1,
      user_id: 1,
      accepted: false
    ))
  end

  xit 'renders the edit join_request form' do
    render

    assert_select 'form[action=?][method=?]', join_request_path(@join_request), 'post' do

      assert_select 'input#join_request_cicle_id[name=?]', 'join_request[cicle_id]'

      assert_select 'input#join_request_user_id[name=?]', 'join_request[user_id]'

      assert_select 'input#join_request_accepted[name=?]', 'join_request[accepted]'
    end
  end
end
