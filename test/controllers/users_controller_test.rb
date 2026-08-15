require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do       # 新軌道録画面を取得できることというテストを開始します
    get new_user_url             # ユーザー登録画面のURL

    assert_response :success     # ｺﾝﾄﾛｰﾗｰから返ってきた結果が正常だったか確認
    assert_select "h1", text: "ユーザー登録"
    assert_select "form[action='#{users_path}']"              # 入力内容を /users へ送るフォームがあることを確認
    assert_select "input[name='user[email]']"                 # メールアドレス欄があることを確認
    assert_select "input[name='user[password]']"              # パスワード欄があることを確認
    assert_select "input[name='user[password_confirmation]']" # パスワード確認欄があることを確認
    assert_select "input[type='submit'][value='登録する']"     # 「登録する」ボタンがあることを確認
  end


  test "should create user" do
    # 登録処理によってUserが1件増えることを確認する
    assert_difference("User.count", 1) do
      post users_url, params: {
        user: {
          email: "new-user@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    created_user = User.find_by(email: "new-user@example.com")

    # 登録後の移動先とログイン状態を確認する
    assert_redirected_to root_url
    assert_equal created_user.id.to_s, session[:user_id]  # .to_s で数値を文字列に変換
  end

  test "should not create user with invalid parameters" do
    # 不正な入力ではUserが増えないことを確認する
    assert_no_difference("User.count") do
      post users_url, params: {
        user: {
          email: "",
          password: "",
          password_confirmation: ""
        }
      }
    end

    # 入力エラーとして登録画面が再表示されることを確認する
    assert_response :unprocessable_entity
    assert_select "p", text: "入力内容を確認してください"
  end
end
