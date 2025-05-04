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
end
