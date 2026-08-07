require "test_helper"

class LetterTest < ActiveSupport::TestCase
  test "belongs to a pet" do
    association = Letter.reflect_on_association(:pet)

    assert_equal :belongs_to, association.macro
  end
end
