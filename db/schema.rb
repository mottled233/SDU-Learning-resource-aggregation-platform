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

ActiveRecord::Schema.define(version: 20180423040628) do

  create_table "course_department_associations", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "department_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["course_id"], name: "index_course_department_associations_on_course_id"
    t.index ["department_id"], name: "index_course_department_associations_on_department_id"
  end

  create_table "course_keyword_associations", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "keyword_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_keyword_associations_on_course_id"
    t.index ["keyword_id"], name: "index_course_keyword_associations_on_keyword_id"
  end

  create_table "course_knowledge_associations", force: :cascade do |t|
    t.integer  "knowledge_id"
    t.integer  "course_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["course_id"], name: "index_course_knowledge_associations_on_course_id"
    t.index ["knowledge_id"], name: "index_course_knowledge_associations_on_knowledge_id"
  end

  create_table "course_user_associations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_user_associations_on_course_id"
    t.index ["user_id"], name: "index_course_user_associations_on_user_id"
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
    t.index ["user_id"], name: "index_focus_knowledge_associations_on_user_id"
  end

  create_table "keyword_knowledge_associations", force: :cascade do |t|
    t.integer  "knowledge_id"
    t.integer  "keyword_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["keyword_id"], name: "index_keyword_knowledge_associations_on_keyword_id"
    t.index ["knowledge_id"], name: "index_keyword_knowledge_associations_on_knowledge_id"
  end

  create_table "keyword_relationships", force: :cascade do |t|
    t.integer  "higher_id"
    t.integer  "lower_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["higher_id"], name: "index_keyword_relationships_on_higher_id"
    t.index ["lower_id"], name: "index_keyword_relationships_on_lower_id"
  end

  create_table "keywords", force: :cascade do |t|
    t.string   "name"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_keywords_on_course_id"
  end

  create_table "knowledges", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "topic_id"
    t.string   "title"
    t.string   "type"
    t.string   "content"
    t.string   "attachment"
    t.integer  "good"
    t.integer  "bad"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["user_id"], name: "index_notifications_on_user_id"
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
    t.index ["username"], name: "index_users_on_username"
  end

end
