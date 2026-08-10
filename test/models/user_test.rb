require "test_helper"   # Railsテストを始めるための準備

class UserTest < ActiveSupport::TestCase
  # 「Userは複数のPetを持つ」ことの確認
  test "has many pets" do
    association = User.reflect_on_association(:pets)

    assert_equal :has_many, association.macro
    assert_equal :destroy, association.options[:dependent]
  end

  # 「UserはPet経由でLetterを持つ」ことの確認
  test "has many letters through pets" do
    association = User.reflect_on_association(:letters)

    assert_equal :has_many, association.macro
    assert_equal :pets, association.options[:through]
  end

  # 「２つのパスワードが一致する」ことの確認
  test "password and confirmation must match" do
  user = User.new(
    email: "confirmation@example.com",
    password: "password",
    password_confirmation: "different"
  )

  assert_not user.valid?
  assert_includes user.errors.details[:password_confirmation],
                  { error: :confirmation, attribute: "Password" }
  end

  # 「メールアドレスは必須」の確認
  test "email must be present" do
  user = User.new(
    password: "password",
    password_confirmation: "password"
  )

  assert_not user.valid?
  assert_includes user.errors.details[:email],
                  { error: :blank }
  end

  # 「メールアドレスは重複不可」の確認
  test "email must be unique" do
    User.create!(
      email: "duplicate@example.com",
      password: "password",
      password_confirmation: "password"
    )

    duplicate_user = User.new(
      email: "duplicate@example.com",
      password: "password",
      password_confirmation: "password"
    )

    assert_not duplicate_user.valid?
    assert duplicate_user.errors.of_kind?(:email, :taken)
  end

  # 「新規登録時のパスワードは必須」の確認
  test "password must be present when creating a user" do
  user = User.new(
    email: "password@example.com",
    password_confirmation: ""
  )

  # 「パスワードが空のユーザーは登録できないこと」を確認するテスト
  assert_not user.valid?
  assert user.errors.of_kind?(:password, :blank)
  end

  test "duplicate email error is displayed in Japanese" do
    User.create!(
      email: "japanese-error@example.com",
      password: "password",
      password_confirmation: "password"
    )

    duplicate_user = User.new(
      email: "japanese-error@example.com",
      password: "password",
      password_confirmation: "password"
    )

    duplicate_user.valid? # 重複エラーを作る

    assert_includes duplicate_user.errors.full_messages,
                    "メールアドレスはすでに登録されています"
  end
end
