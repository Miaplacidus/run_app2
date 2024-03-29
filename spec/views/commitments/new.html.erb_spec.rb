require 'rails_helper'

RSpec.describe 'commitments/new', type: :view do
  before(:each) do
    assign(:commitment, Commitment.new(
      amount: 1.5,
      fulfilled: false,
      post_id: 1,
      user_id: 1
    ))
  end

  it 'renders new commitment form' do
    render

    assert_select 'form[action=?][method=?]', commitments_path, 'post' do

      assert_select 'input#commitment_amount[name=?]', 'commitment[amount]'

      assert_select 'input#commitment_fulfilled[name=?]', 'commitment[fulfilled]'

      assert_select 'input#commitment_post_id[name=?]', 'commitment[post_id]'

      assert_select 'input#commitment_user_id[name=?]', 'commitment[user_id]'
    end
  end
end
