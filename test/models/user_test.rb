require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user2 = users(:michael)
    @user = User.new(first_name: "Example", last_name: "User", email: "user@upenn.edu",
                     password: "foobars")
  end

  test "should be valid" do
    Prospect.create(recommender_id:@user2.id, email:'user@upenn.edu', description: "good",firstName:'C', lastName:'B')
    assert @user.valid?
  end

  test "first name should be present" do
    @user.first_name = "     "
    assert_not @user.valid?
  end

  test "last name should be present" do
    @user.last_name = "     "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 254 + "@upenn.edu"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@upenn.edu USER@upenn.edu A_US-ER@upenn.edu
                         first.last@upenn.edu alice+bob@upenn.edu]
    valid_addresses.each do |valid_address|
      Prospect.create(recommender_id:@user2.id, email:valid_address, description: "good", firstName:'C', lastName:'B')
      @user.update_attribute(:email, valid_address)
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "first trailing space shouldn't exist" do

  end

  test "last trailing space shouldn't exist" do

  end

end
