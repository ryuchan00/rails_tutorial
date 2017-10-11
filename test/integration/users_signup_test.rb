require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    # assert_no_difference(exp [,msg]) {block}
    # ブロック配下の処理を実行した前後で式expの値が変化しないか
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    # assert_template(temp [, msg])
    # 指定されたテンプレートが選択されたか
    # assert_template 'users/new'
    assert_select 'form[action="/signup"]'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    get signup_path
    # assert_difference
    # yieldされたブロックで評価された結果である式の戻り値における数値の違いをテストする。
    assert_difference 'User.count', 2 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
      post users_path, params: { user: { name:  "Example User2",
                                         email: "user2@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    # リダイレクト前のページに遷移する
    follow_redirect!
    assert_template 'users/show'
    # 式がfalseか判定
    assert_not flash.empty?
  end
end
