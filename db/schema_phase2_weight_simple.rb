# Phase 2: 認証 + 体重管理（簡略版）
# 機能: Phase 1 + 体重記録、目標体重設定、体重履歴
# 注: profile_image は省略（後から追加可能）

ActiveRecord::Schema[7.2].define(version: 2025_01_02_000001) do
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
    # t.string "profile_image"  # 省略（後から追加可能）

    # OAuth認証用
    t.string "provider"
    t.string "uid"

    # 体重管理機能
    t.decimal "target_weight", precision: 5, scale: 2
    t.decimal "current_weight", precision: 5, scale: 2

    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weight_records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "weight", precision: 5, scale: 2, null: false
    t.datetime "recorded_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  # Foreign Keys
  add_foreign_key "weight_records", "users"
end
