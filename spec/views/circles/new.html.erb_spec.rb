require 'rails_helper'

RSpec.describe 'circles/new', type: :view do
  before(:each) do
    assign(:circle, Circle.new(
      name: 'MyString',
      max_members: 1,
      latitude: 1.5,
      longitude: 1.5,
      description: 'MyText',
      level: 1,
      city: 'MyString',
      admin_id: 1
    ))
  end

  xit 'renders new circle form' do
    render

    assert_select 'form[action=?][method=?]', circles_path, 'post' do

      assert_select 'input#circle_name[name=?]', 'circle[name]'

      assert_select 'input#circle_max_members[name=?]', 'circle[max_members]'

      assert_select 'input#circle_latitude[name=?]', 'circle[latitude]'

      assert_select 'input#circle_longitude[name=?]', 'circle[longitude]'

      assert_select 'textarea#circle_description[name=?]', 'circle[description]'

      assert_select 'input#circle_level[name=?]', 'circle[level]'

      assert_select 'input#circle_city[name=?]', 'circle[city]'

      assert_select 'input#circle_admin_id[name=?]', 'circle[admin_id]'
    end
  end
end
