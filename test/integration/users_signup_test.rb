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

end
