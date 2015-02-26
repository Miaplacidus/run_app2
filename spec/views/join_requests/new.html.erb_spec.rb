require 'rails_helper'

RSpec.describe 'join_requests/new', type: :view do
  before(:each) do
    assign(:join_request, JoinRequest.new(
      cicle_id: 1,
      user_id: 1,
      accepted: false
    ))
  end

  xit 'renders new join_request form' do
    render

    assert_select 'form[action=?][method=?]', join_requests_path, 'post' do

      assert_select 'input#join_request_cicle_id[name=?]', 'join_request[cicle_id]'

      assert_select 'input#join_request_user_id[name=?]', 'join_request[user_id]'

      assert_select 'input#join_request_accepted[name=?]', 'join_request[accepted]'
    end
  end
end
