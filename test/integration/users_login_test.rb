
require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

    def setup
    @user = users(:michael)
    end

    test "login with valid information" do
        get login_path
        post login_path, session: { email: @user.email, password: 'password' }
        assert_redirected_to @user
        follow_redirect!
        assert_template 'users/show'
        assert_select "a[href=?]", login_path, count: 0
        assert_select "a[href=?]", logout_path
       
    end

    test "login with valid information followed by logout" do
        get login_path
        post login_path, session: { email: @user.email, password: 'password' }
        assert is_logged_in?
        assert_redirected_to @user
        follow_redirect!
        assert_template 'users/show'
        assert_select "a[href=?]", login_path, count: 0 #there is NO link to LOGIN
        assert_select "a[href=?]", logout_path #there IS a link to LOGOUT
        delete logout_path
        assert_not is_logged_in?
        assert_redirected_to root_url
        follow_redirect!
        # Assert that there is no link to 'Your list' or 'Profile'
        assert_select "a[href=?]", login_path
        assert_select "a[href=?]", logout_path,      count: 0
        
    end



end
