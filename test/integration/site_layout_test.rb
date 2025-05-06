require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'layout links' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path

    get contact_path
    assert_select 'title', full_title('Contact')

    get signup_path
    assert_select 'title', full_title('Sign up')

    log_in_as(@user)
    get users_path
    assert_select 'title', full_title('All users')
    assert_select 'a[href=?]', user_path(@user), text: @user.name
    assert_select 'a[href=?]', root_path, text: 'Home'
    assert_select 'a[href=?]', help_path, text: 'Help'
    assert_select 'a[href=?]', users_path, text: 'Users'
    assert_select 'a[href=?]', about_path, text: 'About'
    assert_select 'a[href=?]', contact_path, text: 'Contact'
    assert_select 'a[href=?]', 'https://news.railstutorial.org/', text: 'News'
  end
end
