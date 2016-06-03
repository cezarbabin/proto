require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    assert_no_difference 'User.count' do
      post users_path, user: { first:  "",
                               second: "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { first:  "Example",
                                            last: "User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
  end

end
