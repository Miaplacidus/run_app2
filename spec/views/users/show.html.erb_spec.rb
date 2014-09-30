require 'rails_helper'

RSpec.describe "users/show", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :first_name => "First Name",
      :gender => 1,
      :email => "Email",
      :bday => "Bday",
      :rating => 1.5,
      :fbid => "Fbid",
      :image => "Image",
      :level => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Bday/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/Fbid/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/2/)
  end
end
