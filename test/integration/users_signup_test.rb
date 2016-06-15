require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)

  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { first_name:  "",
                               last_name: "",
                               email: "",
                               password:              "",
                               password_confirmation: "" }
    end
    assert_template 'users/new'
  end

  test "invalid prospect code" do

  end

  test "create a prospect" do
    log_in_as(@user)
    get new_friend_path
    assert_difference 'Prospect.count', 1 do
      post friends_path, friend: {
          email:       "user@upenn.edu",
          description: "good description",
          first_name: 'cez',
          last_name: 'bab'
      }
    end
    #assert_template 'friends/new'
    log_out_of_account
    assert_not is_logged_in?
    #pcode = Prospect.create(recommender_id: @user.id, email:'user@upenn.edu').pcode
  end

  test "valid signup information" do
    log_in_as(@user)
    get new_friend_path
    assert_difference 'Prospect.count', 1 do
      post friends_path, friend: {
          email:       "usertiti@upenn.edu",
          description: "good description",
          first_name: 'cez',
          last_name: 'bab'
      }
    end
    log_out_of_account
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: { first_name:  "Example",
                               last_name: "User",
                               email: "user@upenn.edu",
                               password:              "passwordA9",
                               password_confirmation: "passwordA9",
                            }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?

    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?

    # Password reset before authorization
    get new_password_reset_path
    post password_resets_path, password_reset: { email: user.email }
    assert_equal 1, ActionMailer::Base.deliveries.size


    # Invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?

    # Invalid email
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?

    # Valid information
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert !user.activated?
    assert is_logged_in?
    assert user.reload.activated?

    # See if the right templates are shown
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?

    # See if clicking on the link again brings out error
    # get edit_account_activation_path(user.activation_token, email: user.email)
    # follow_redirect!
    # assert_select 'div#error_explanation'


  end
end
