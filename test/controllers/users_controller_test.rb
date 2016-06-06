require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user       = users(:michael)
    @user2     = users(:archer)
  end

  test 'redirect to login if cant edit' do
    get :edit, id: @user
    assert_redirected_to login_url
  end

  test 'redirect to login if not logged in but trying to see' do
    get :show, id: @user
    assert_redirected_to login_url
  end

  test 'redirect to login if cant patch' do
    patch :update, id: @user, user: {}
    assert_redirected_to login_url
  end

  test 'try to edit as stranger' do
    log_in_as(@user2)
    get :edit, id: @user
    assert_redirected_to root_url
  end

  test 'redirect to root if logged in but trying to see others info' do
    log_in_as(@user2)
    get :show, id: @user
    assert_redirected_to root_url
  end

  test 'try to patch as stranger' do
    log_in_as(@user2)
    patch :update, id: @user, user: {first:@user.first}
    assert_redirected_to root_url
  end

  test "try to submit information with redirect happening" do
    log_in_as(@user2)
    first  = "Foo Bar"
    email = "foo@bar.com"
    patch :update, id: @user, user: {first:first, email:email}
    assert_redirected_to root_url
    @user.reload
    assert_not_equal first,  @user.first
    assert_not_equal email, @user.email
  end


end
