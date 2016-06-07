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



end
