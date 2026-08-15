require "test_helper"

class LetterTest < ActiveSupport::TestCase
  test "belongs to a pet" do
    association = Letter.reflect_on_association(:pet)

    assert_equal :belongs_to, association.macro
  end

  test "reply becomes available after the configured wait time" do
    user = User.create!(
      email: "letter-owner@example.com",
      password: "password",
      password_confirmation: "password"
    )
    pet = user.pets.create!(name: "こむぎ")
    wait_time = Rails.application.config.x.reply_wait_time
    letter = pet.letters.create!(
      content: "こむぎへの手紙",
      status: "sent",
      sent_at: Time.current - wait_time - 1.second
    )
    letter.create_reply!(content: "管理人からの手紙")

    assert letter.reply_available?

    letter.update!(sent_at: Time.current)

    assert_not letter.reply_available?
  end
end
