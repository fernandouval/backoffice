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

ActiveRecord::Schema[7.0].define(version: 2022_03_27_143946) do
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
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "analysts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.index ["confirmation_token"], name: "index_analysts_on_confirmation_token", unique: true
    t.index ["email"], name: "index_analysts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_analysts_on_reset_password_token", unique: true
  end

  create_table "backofficers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.index ["confirmation_token"], name: "index_backofficers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_backofficers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_backofficers_on_reset_password_token", unique: true
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

  create_table "incidents", force: :cascade do |t|
    t.bigint "analyst_id"
    t.bigint "backofficer_id"
    t.string "problem_kind", default: "bug_system"
    t.string "priority_level", default: "low"
    t.string "problem_description"
    t.string "pending_description"
    t.string "solution_description"
    t.string "reopened_description"
    t.string "user_email"
    t.string "contract_id"
    t.string "title"
    t.string "status", default: "open"
    t.string "analysis_time"
    t.datetime "analysis_started_at", precision: nil
    t.datetime "solved_at", precision: nil
    t.string "entity"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "evidence_screen_file_name"
    t.string "evidence_screen_content_type"
    t.bigint "evidence_screen_file_size"
    t.datetime "evidence_screen_updated_at", precision: nil
    t.string "plataform_kind"
    t.string "captured_by"
    t.string "pending_reason"
    t.string "reopening_description"
    t.boolean "incident_reopened", default: false
    t.string "reopened_by"
    t.string "user_name"
    t.index ["analyst_id"], name: "index_incidents_on_analyst_id"
    t.index ["backofficer_id"], name: "index_incidents_on_backofficer_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "title"
    t.text "description"
    t.date "end_date"
    t.decimal "fixed_price"
    t.decimal "worked_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "deadline_id"
    t.index ["client_id"], name: "index_tasks_on_client_id"
    t.index ["deadline_id"], name: "index_tasks_on_deadline_id"
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
    t.index ["client_id"], name: "index_websites_on_client_id"
  end

  add_foreign_key "deadlines", "clients"
  add_foreign_key "tasks", "clients"
  add_foreign_key "tasks", "deadlines"
  add_foreign_key "websites", "clients"
end
