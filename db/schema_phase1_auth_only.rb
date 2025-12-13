# Phase 1: ユーザー認証のみ
# 機能: ユーザー登録、ログイン、パスワードリセット、OAuth認証

ActiveRecord::Schema[7.2].define(version: 2025_01_01_000001) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    # Devise 認証フィールド
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"

    # プロフィール基本情報
    t.string "name", null: false
    t.string "profile_image"

    # OAuth認証用
    t.string "provider"
    t.string "uid"

    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  # 外部キーなし（単一テーブル）
end
