require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                         email: 'user@invalid',
                                         password: 'foo',
                                         password_confirmation: 'bar' } }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
    assert_select 'div#error_explanation li', "Name can't be blank"
    assert_select 'div#error_explanation li', 'Email is invalid'
    assert_select 'div#error_explanation li', 'Password is too short (minimum is 6 characters)'
    assert_select 'div#error_explanation li', "Password confirmation doesn't match Password"
  end

  test 'valid signup information' do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'Example User',
                                         email: 'user@example.com',
                                         password: 'password',
                                         password_confirmation: 'password' } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert flash[:success] == 'Welcome to the Sample App!'
    assert_not flash.include? :danger
  end
end
