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

  test "name must be present" do
    user = User.create!(
      email: "pet-owner@example.com",
      password: "password",
      password_confirmation: "password"
    )
    pet = user.pets.build(name: "")

    assert_not pet.valid?
    assert pet.errors.of_kind?(:name, :blank)
  end
end
