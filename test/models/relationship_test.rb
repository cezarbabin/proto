require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @relationship = Relationship.new(recommender_id: 1, recommended_id: 2, description:"valid")
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  #test "relationships cant be duplicate" Can only be tested in the console on db save

  test "should require a recommender_id" do
    @relationship.recommender_id = nil
    assert_not @relationship.valid?
  end

  test "should require a recommended_id" do
    @relationship.recommended_id = nil
    assert_not @relationship.valid?
  end



end
