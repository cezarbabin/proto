require 'test_helper'

class ProspectsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:michael)
    @user2 = users(:archer)
  end

  test "invalid recommendation information" do
    log_in_as(@user)
    get new_prospect_path
    assert_no_difference ['Prospect.count', 'Relationship.count'] do
      post prospects_path, prospect: {
                               email:       "",
                               description: "",
                              }
    end
    assert_template 'prospects/new'
    #check if the error marks under the form tabs come up
  end

  test "valid recommendation information" do
    log_in_as(@user)
    get new_prospect_path
    assert_difference ['Prospect.count', 'Relationship.count'],1 do
      post prospects_path, prospect: {
          email:       "czbabin@gmai.com",
          description: "good description",
      }
    end
    assert_template 'prospects/new'
  end

  test "recommending herself" do
    log_in_as(@user)
    get new_prospect_path
    assert_no_difference ['Prospect.count', 'Relationship.count'] do
      post prospects_path, prospect: {
          email:       @user.email,
          description: "good description",
      }
    end
    assert_template 'prospects/new'
    #check if the error marks under the form tabs come up
  end

  test "recommending herself and giving bad description" do
    log_in_as(@user)
    get new_prospect_path
    assert_no_difference ['Prospect.count', 'Relationship.count'] do
      post prospects_path, prospect: {
          email:       @user.email,
          description: "oh",
      }
    end
    assert_template 'prospects/new'
    #check if the error marks under the form tabs come up
  end

  test "valid email with invalid description" do
    log_in_as(@user)
    get new_prospect_path
    assert_no_difference ['Prospect.count', 'Relationship.count'] do
      post prospects_path, prospect: {
          email:       @user.email + 'ce',
          description: "oh",
      }
    end
    assert_template 'prospects/new'
  end

  test "prospect is already an user" do
    log_in_as(@user)
    get new_prospect_path
    assert_no_difference 'Prospect.count' do
      post prospects_path, prospect: {
          email:       @user2.email,
          description: "already an user",
      }
    end
  end

  test "try and make more than 5 prospects" do
    log_in_as(@user)
    get new_prospect_path
    assert_difference ['Prospect.count', 'Relationship.count'], 1 do
      post prospects_path, prospect: {
          email:       @user2.email+'z',
          description: "already an user",
      }
    end
    assert_difference ['Prospect.count', 'Relationship.count'], 1 do
      post prospects_path, prospect: {
          email:       @user2.email+'2',
          description: "already an user",
      }
    end
    assert_difference ['Prospect.count', 'Relationship.count'], 1 do
      post prospects_path, prospect: {
          email:       @user2.email+'3',
          description: "already an user",
      }
    end
    assert_difference ['Prospect.count', 'Relationship.count'], 1 do
      post prospects_path, prospect: {
          email:       @user2.email+'4',
          description: "already an user",
      }
    end
    assert_difference ['Prospect.count', 'Relationship.count'], 1 do
      post prospects_path, prospect: {
          email:       @user2.email+'5',
          description: "already an user",
      }
    end
    assert_no_difference ['Prospect.count', 'Relationship.count'] do
      post prospects_path, prospect: {
          email:       @user2.email+'6',
          description: "already an user",
      }
    end
  end



end
