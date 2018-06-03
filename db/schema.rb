# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180523120108) do

  create_table "bad_associations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "knowledge_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["knowledge_id"], name: "index_bad_associations_on_knowledge_id"
    t.index ["user_id", "knowledge_id"], name: "unique_index_on_ba", unique: true
    t.index ["user_id"], name: "index_bad_associations_on_user_id"
  end

  create_table "course_department_associations", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "department_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["course_id", "department_id"], name: "unique_index_on_cda", unique: true
    t.index ["course_id"], name: "index_course_department_associations_on_course_id"
    t.index ["department_id"], name: "index_course_department_associations_on_department_id"
  end

  create_table "course_keyword_associations", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "keyword_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "keyword_id"], name: "unique_index_on_ckeya", unique: true
    t.index ["course_id"], name: "index_course_keyword_associations_on_course_id"
    t.index ["keyword_id"], name: "index_course_keyword_associations_on_keyword_id"
  end

  create_table "course_knowledge_associations", force: :cascade do |t|
    t.integer  "knowledge_id"
    t.integer  "course_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["course_id", "knowledge_id"], name: "unique_index_on_cka", unique: true
    t.index ["course_id"], name: "index_course_knowledge_associations_on_course_id"
    t.index ["knowledge_id"], name: "index_course_knowledge_associations_on_knowledge_id"
  end

  create_table "course_speciality_associations", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "speciality_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["course_id", "speciality_id"], name: "unique_index_on_csa", unique: true
    t.index ["course_id"], name: "index_course_speciality_associations_on_course_id"
    t.index ["speciality_id"], name: "index_course_speciality_associations_on_speciality_id"
  end

  create_table "course_user_associations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_user_associations_on_course_id"
    t.index ["user_id", "course_id"], name: "index_course_user_associations_on_user_id_and_course_id", unique: true
    t.index ["user_id"], name: "index_course_user_associations_on_user_id"
  end

  create_table "course_visits", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_visits_on_course_id"
    t.index ["user_id"], name: "index_course_visits_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "course_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "focus_knowledge_associations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "knowledge_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["knowledge_id"], name: "index_focus_knowledge_associations_on_knowledge_id"
    t.index ["user_id", "knowledge_id"], name: "unique_index_on_fka", unique: true
    t.index ["user_id"], name: "index_focus_knowledge_associations_on_user_id"
  end

  create_table "good_associations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "knowledge_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["knowledge_id"], name: "index_good_associations_on_knowledge_id"
    t.index ["user_id", "knowledge_id"], name: "unique_index_on_ga", unique: true
    t.index ["user_id"], name: "index_good_associations_on_user_id"
  end

  create_table "keyword_knowledge_associations", force: :cascade do |t|
    t.integer  "knowledge_id"
    t.integer  "keyword_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["keyword_id", "knowledge_id"], name: "unique_index_on_kka", unique: true
    t.index ["keyword_id"], name: "index_keyword_knowledge_associations_on_keyword_id"
    t.index ["knowledge_id"], name: "index_keyword_knowledge_associations_on_knowledge_id"
  end

  create_table "keyword_relationships", force: :cascade do |t|
    t.integer  "higher_id"
    t.integer  "lower_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["higher_id", "lower_id"], name: "unique_index_on_keya", unique: true
    t.index ["higher_id"], name: "index_keyword_relationships_on_higher_id"
    t.index ["lower_id"], name: "index_keyword_relationships_on_lower_id"
  end

  create_table "keywords", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "knowledge_visits", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "knowledge_id"
    t.integer  "count"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["knowledge_id"], name: "index_knowledge_visits_on_knowledge_id"
    t.index ["user_id"], name: "index_knowledge_visits_on_user_id"
  end

  create_table "knowledges", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "knowledge_id"
    t.string   "title"
    t.string   "type"
    t.string   "content"
    t.string   "attachment"
    t.string   "knowledge_digest"
    t.integer  "good",             default: 0
    t.integer  "bad",              default: 0
    t.integer  "visit_count",      default: 0
    t.integer  "download_count",   default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.datetime "last_reply_at"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "notify_type"
    t.integer  "notify_entity_id"
    t.string   "entity_type"
    t.integer  "with_entity_id"
    t.string   "with_entity_type"
    t.integer  "initiator_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.boolean  "checked"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "specialities", force: :cascade do |t|
    t.string   "name"
    t.integer  "department_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["department_id"], name: "index_specialities_on_department_id"
    t.index ["name"], name: "index_specialities_on_name"
  end

  create_table "user_configs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "courses_notification_config"
    t.string   "knowledges_notification_config"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["user_id"], name: "index_user_configs_on_user_id"
  end

  create_table "user_follow_associations", force: :cascade do |t|
    t.integer  "following_id"
    t.integer  "followed_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["followed_id"], name: "index_user_follow_associations_on_followed_id"
    t.index ["following_id", "followed_id"], name: "unique_index_on_uua", unique: true
    t.index ["following_id"], name: "index_user_follow_associations_on_following_id"
  end

  create_table "user_keyword_associations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "keyword_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["keyword_id"], name: "index_user_keyword_associations_on_keyword_id"
    t.index ["user_id", "keyword_id"], name: "unique_index_on_uka", unique: true
    t.index ["user_id"], name: "index_user_keyword_associations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "user_role"
    t.string   "nickname"
    t.string   "email"
    t.string   "phone_number"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "last_check_time"
    t.string   "sex"
    t.integer  "grade"
    t.date     "birthday"
    t.string   "user_class"
    t.integer  "department_id"
    t.integer  "speciality_id"
    t.text     "self_introduce"
    t.string   "department"
    t.string   "speciality"
    t.index ["username"], name: "index_users_on_username"
  end

end
