require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
    @user2 = users(:archer)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name:  "",
                                    email: "foo@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    first  = "Foo"
    last = " Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { first:  first,
                                    last: last,
                                    password:              "",
                                    password_confirmation: "" }
    assert_template 'users/edit'
    @user.reload
    assert_equal first,  @user.first
    assert_equal last,  @user.last
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
  end



end
