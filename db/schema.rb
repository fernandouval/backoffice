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

ActiveRecord::Schema[7.0].define(version: 2023_02_06_205122) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "name"
    t.string "phone"
    t.string "personal_email"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.text "comment"
    t.boolean "send_email"
    t.boolean "visible"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "admin_user_id", null: false
    t.string "title"
    t.time "worked_time"
    t.index ["admin_user_id"], name: "index_answers_on_admin_user_id"
    t.index ["task_id"], name: "index_answers_on_task_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deadlines", force: :cascade do |t|
    t.date "ddate"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "client_id", null: false
    t.index ["client_id"], name: "index_deadlines_on_client_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "end_date"
    t.decimal "fixed_price"
    t.decimal "worked_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "deadline_id"
    t.integer "status"
    t.integer "priority"
    t.bigint "website_id", null: false
    t.bigint "admin_user_id"
    t.decimal "estimated_hours", precision: 4, scale: 2
    t.date "closed_at"
    t.integer "completeness"
    t.bigint "task_id"
    t.bigint "depends_on_id"
    t.index ["admin_user_id"], name: "index_tasks_on_admin_user_id"
    t.index ["deadline_id"], name: "index_tasks_on_deadline_id"
    t.index ["depends_on_id"], name: "index_tasks_on_depends_on_id"
    t.index ["task_id"], name: "index_tasks_on_task_id"
    t.index ["website_id"], name: "index_tasks_on_website_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "websites", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "url"
    t.string "admin"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "client_id", null: false
    t.boolean "is_hosted"
    t.boolean "is_managed"
    t.date "last_dev_migration"
    t.date "hosting_expiration_date"
    t.index ["client_id"], name: "index_websites_on_client_id"
  end

  add_foreign_key "answers", "admin_users"
  add_foreign_key "answers", "tasks"
  add_foreign_key "deadlines", "clients"
  add_foreign_key "tasks", "admin_users"
  add_foreign_key "tasks", "deadlines"
  add_foreign_key "tasks", "tasks"
  add_foreign_key "tasks", "tasks", column: "depends_on_id"
  add_foreign_key "tasks", "websites"
  add_foreign_key "websites", "clients"
end
