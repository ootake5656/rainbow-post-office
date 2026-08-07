require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "has many pets" do
    association = User.reflect_on_association(:pets)

    assert_equal :has_many, association.macro
    assert_equal :destroy, association.options[:dependent]
  end

  test "has many letters through pets" do
    association = User.reflect_on_association(:letters)

    assert_equal :has_many, association.macro
    assert_equal :pets, association.options[:through]
  end
end
