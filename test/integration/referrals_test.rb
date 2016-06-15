require 'test_helper'

class ReferralsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:michael)
    @user2 = users(:archer)
  end

  test "invalid recommendation information" do
    log_in_as(@user)
    get new_friend_path
    assert_no_difference ['Prospect.count', 'Relationship.count'] do
      post friends_path, friend: {
                               email:       "",
                               description: "",
                              }
    end
    #assert_template 'friends/new'
    #check if the error marks under the form tabs come up
  end

  test "valid recommendation information" do
    log_in_as(@user)
    get new_friend_path
    assert_difference 'Prospect.count', 1 do
      post friends_path, friend: {
          email:       "czrabin@upenn.edu",
          description: "good description",
          first_name: 'cez',
          last_name: 'bab'
      }
    end
    #assert_template 'friends/new'
  end

  test "recommending herself" do
    log_in_as(@user)
    get new_friend_path
    assert_no_difference ['Prospect.count', 'Relationship.count'] do
      post friends_path, friend: {
          email:       @user.email,
          description: "good description",
      }
    end
    #assert_template 'friends/new'
    #check if the error marks under the form tabs come up
  end

  test "recommending herself and giving bad description" do
    log_in_as(@user)
    get new_friend_path
    assert_no_difference ['Prospect.count', 'Relationship.count'] do
      post friends_path, friend: {
          email:       @user.email,
          description: "oh",
      }
    end
    #assert_template 'friends/new'
    #check if the error marks under the form tabs come up
  end

  test "valid email with invalid description" do
    log_in_as(@user)
    get new_friend_path
    assert_no_difference ['Prospect.count', 'Relationship.count'] do
      post friends_path, friend: {
          email:       'ce' + @user.email,
          description: "oh",
      }
    end
    #assert_template 'friends/new'
  end

  test "prospect is already an user" do
    log_in_as(@user)
    get new_friend_path
    assert_no_difference 'Prospect.count' do
      post friends_path, friend: {
          email:       @user2.email,
          description: "already an user",
      }
    end
  end

  test "try and make more than 5 prospects" do
    log_in_as(@user)
    get new_friend_path
    assert_equal Prospect.count, 0
    assert_difference [ 'Prospect.count'], 1 do
      post friends_path, friend: {
          email:       'z' + @user2.email,
          description: "already an user",
          first_name: 'cez',
          last_name: 'bab'
      }
    end
    assert_difference [ 'Prospect.count'], 1 do
      post friends_path, friend: {
          email:       'm'+ @user2.email,
          description: "already an user",
          first_name: 'cez',
          last_name: 'bab'
      }
    end
    assert_difference ['Prospect.count'], 1 do
      post friends_path, friend: {
          email:       'b'+@user2.email,
          description: "already an user",
          first_name: 'cez',
          last_name: 'bab'
      }
    end
    assert_difference ['Prospect.count'], 1 do
      post friends_path, friend: {
          email:       'o' + @user2.email,
          description: "already an user",
          first_name: 'cez',
          last_name: 'bab'
      }
    end
    assert_difference [ 'Prospect.count'], 1 do
      post friends_path, friend: {
          email:       'r' + @user2.email,
          description: "already an user",
          first_name: 'cez',
          last_name: 'bab'
      }
    end
    assert_no_difference ['Prospect.count'] do
      post friends_path, friend: {
          email:       'a' + @user2.email,
          description: "already an user",
          first_name: 'cez',
          last_name: 'bab'
      }
    end
    assert_no_difference ['Relationship.count'] do
      post friends_path, friend: {
          email:       's' + @user2.email,
          description: "already an user",
          first_name: 'cez',
          last_name: 'bab'
      }
    end
    assert_no_difference ['Prospect.count'] do
      post friends_path, friend: {
          email:       's' + @user2.email,
          description: "already an user",
          first_name: 'cez',
          last_name: 'bab'
      }
    end
  end



end
