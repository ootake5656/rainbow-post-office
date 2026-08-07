require "test_helper"

class PetTest < ActiveSupport::TestCase
  test "belongs to a user" do
    association = Pet.reflect_on_association(:user)

    assert_equal :belongs_to, association.macro
  end

  test "has many letters" do
    association = Pet.reflect_on_association(:letters)

    assert_equal :has_many, association.macro
    assert_equal :destroy, association.options[:dependent]
  end
end
