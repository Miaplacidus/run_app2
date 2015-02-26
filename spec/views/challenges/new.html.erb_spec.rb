require 'rails_helper'

RSpec.describe 'challenges/new', type: :view do
  before(:each) do
    assign(:challenge, Challenge.new(
      name: 'MyString',
      sender_id: 1,
      recipient_id: 1,
      post_id: 1,
      state: 'MyString',
      notes: 'MyText'
    ))
  end

  it 'renders new challenge form' do
    render

    assert_select 'form[action=?][method=?]', challenges_path, 'post' do

      assert_select 'input#challenge_name[name=?]', 'challenge[name]'

      assert_select 'input#challenge_sender_id[name=?]', 'challenge[sender_id]'

      assert_select 'input#challenge_recipient_id[name=?]', 'challenge[recipient_id]'

      assert_select 'input#challenge_post_id[name=?]', 'challenge[post_id]'

      assert_select 'input#challenge_state[name=?]', 'challenge[state]'

      assert_select 'textarea#challenge_notes[name=?]', 'challenge[notes]'
    end
  end
end
