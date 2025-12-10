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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weight_records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "weight", precision: 5, scale: 2, null: false
    t.datetime "recorded_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_weight_records_on_user_id"
    t.index ["user_id", "recorded_at"], name: "index_weight_records_on_user_id_and_recorded_at"
  end

  create_table "follow_relationships", force: :cascade do |t|
    t.bigint "follower_id", null: false
    t.bigint "followee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id", "followee_id"], name: "index_follow_relationships_on_follower_and_followee", unique: true
    t.index ["follower_id"], name: "index_follow_relationships_on_follower_id"
    t.index ["followee_id"], name: "index_follow_relationships_on_followee_id"
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
    t.index ["room_master_id"], name: "index_rooms_on_room_master_id"
    t.index ["room_type"], name: "index_rooms_on_room_type"
    t.index ["is_public"], name: "index_rooms_on_is_public"
    t.index ["expires_at"], name: "index_rooms_on_expires_at"
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
    t.index ["room_id", "user_id"], name: "index_room_memberships_on_room_and_user", unique: true
    t.index ["room_id"], name: "index_room_memberships_on_room_id"
    t.index ["user_id"], name: "index_room_memberships_on_user_id"
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
    t.index ["room_id"], name: "index_room_invitations_on_room_id"
    t.index ["invited_by_user_id"], name: "index_room_invitations_on_invited_by_user_id"
    t.index ["invited_user_id"], name: "index_room_invitations_on_invited_user_id"
    t.index ["invitation_token"], name: "index_room_invitations_on_invitation_token", unique: true
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
    t.index ["point_type"], name: "index_chokkai_templates_on_point_type"
    t.index ["level"], name: "index_chokkai_templates_on_level"
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
    t.index ["chokkai_template_id"], name: "index_chokkai_instances_on_chokkai_template_id"
    t.index ["from_user_id"], name: "index_chokkai_instances_on_from_user_id"
    t.index ["to_user_id"], name: "index_chokkai_instances_on_to_user_id"
    t.index ["room_id"], name: "index_chokkai_instances_on_room_id"
    t.index ["status"], name: "index_chokkai_instances_on_status"
    t.index ["created_at"], name: "index_chokkai_instances_on_created_at"
  end

  create_table "user_chokkai_blacklists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chokkai_template_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "chokkai_template_id"], name: "index_user_chokkai_blacklist_on_user_and_template", unique: true
    t.index ["user_id"], name: "index_user_chokkai_blacklists_on_user_id"
    t.index ["chokkai_template_id"], name: "index_user_chokkai_blacklists_on_chokkai_template_id"
  end

  create_table "titles", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "icon"
    t.integer "condition_type", null: false
    t.string "condition_value"
    t.integer "title_category", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["condition_type"], name: "index_titles_on_condition_type"
    t.index ["title_category"], name: "index_titles_on_title_category"
  end

  create_table "user_titles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "title_id", null: false
    t.datetime "earned_at", null: false
    t.boolean "is_equipped", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "title_id"], name: "index_user_titles_on_user_and_title", unique: true
    t.index ["user_id"], name: "index_user_titles_on_user_id"
    t.index ["title_id"], name: "index_user_titles_on_title_id"
    t.index ["is_equipped"], name: "index_user_titles_on_is_equipped"
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
    t.index ["room_id"], name: "index_room_messages_on_room_id"
    t.index ["user_id"], name: "index_room_messages_on_user_id"
    t.index ["stamp_id"], name: "index_room_messages_on_stamp_id"
    t.index ["created_at"], name: "index_room_messages_on_created_at"
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
    t.index ["user_id"], name: "index_point_histories_on_user_id"
    t.index ["room_id"], name: "index_point_histories_on_room_id"
    t.index ["point_type"], name: "index_point_histories_on_point_type"
    t.index ["action_type"], name: "index_point_histories_on_action_type"
    t.index ["created_at"], name: "index_point_histories_on_created_at"
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
  add_foreign_key "user_titles", "users"
  add_foreign_key "user_titles", "titles"
  add_foreign_key "room_messages", "rooms"
  add_foreign_key "room_messages", "users"
  add_foreign_key "room_messages", "stamps"
  add_foreign_key "point_histories", "users"
  add_foreign_key "point_histories", "rooms"
end
