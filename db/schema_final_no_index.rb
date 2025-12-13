# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_12_31_999999) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.decimal "target_weight", precision: 5, scale: 2
    t.decimal "current_weight", precision: 5, scale: 2
    t.string "profile_image"
    t.string "provider"
    t.string "uid"
    t.integer "total_room_battle_points", default: 0
    t.integer "total_raid_points", default: 0
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

  create_table "follow_relationships", force: :cascade do |t|
    t.bigint "follower_id", null: false
    t.bigint "followee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name", null: false
    t.integer "room_type", default: 0, null: false
    t.boolean "is_public", default: false, null: false
    t.integer "max_members", default: 10, null: false
    t.integer "invitation_period"
    t.integer "duration"
    t.datetime "expires_at"
    t.bigint "room_master_id", null: false
    t.decimal "target_weight", precision: 6, scale: 2
    t.integer "daily_chokkai_limit", default: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "room_memberships", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.bigint "user_id", null: false
    t.decimal "personal_target_weight", precision: 5, scale: 2
    t.datetime "joined_at", null: false
    t.integer "status", default: 0, null: false
    t.integer "points_used_in_room", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "room_invitations", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.bigint "invited_by_user_id", null: false
    t.bigint "invited_user_id"
    t.string "invitation_token", null: false
    t.datetime "expires_at", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chokkai_templates", force: :cascade do |t|
    t.string "name", null: false
    t.text "content", null: false
    t.text "description"
    t.integer "level", default: 1
    t.integer "attack_power", default: 0
    t.integer "point_cost", default: 0, null: false
    t.integer "point_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chokkai_instances", force: :cascade do |t|
    t.bigint "chokkai_template_id", null: false
    t.bigint "from_user_id", null: false
    t.bigint "to_user_id"
    t.string "to_cpu_boss"
    t.bigint "room_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_chokkai_blacklists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chokkai_template_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stamps", force: :cascade do |t|
    t.string "name", null: false
    t.string "image_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "room_messages", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.bigint "user_id", null: false
    t.bigint "stamp_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "point_histories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "room_id"
    t.integer "point_type", null: false
    t.integer "amount", null: false
    t.integer "action_type", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  # Foreign Keys
  add_foreign_key "weight_records", "users"
  add_foreign_key "follow_relationships", "users", column: "follower_id"
  add_foreign_key "follow_relationships", "users", column: "followee_id"
  add_foreign_key "rooms", "users", column: "room_master_id"
  add_foreign_key "room_memberships", "rooms"
  add_foreign_key "room_memberships", "users"
  add_foreign_key "room_invitations", "rooms"
  add_foreign_key "room_invitations", "users", column: "invited_by_user_id"
  add_foreign_key "room_invitations", "users", column: "invited_user_id"
  add_foreign_key "chokkai_instances", "chokkai_templates"
  add_foreign_key "chokkai_instances", "users", column: "from_user_id"
  add_foreign_key "chokkai_instances", "users", column: "to_user_id"
  add_foreign_key "chokkai_instances", "rooms"
  add_foreign_key "user_chokkai_blacklists", "users"
  add_foreign_key "user_chokkai_blacklists", "chokkai_templates"
  add_foreign_key "room_messages", "rooms"
  add_foreign_key "room_messages", "users"
  add_foreign_key "room_messages", "stamps"
  add_foreign_key "point_histories", "users"
  add_foreign_key "point_histories", "rooms"
end
