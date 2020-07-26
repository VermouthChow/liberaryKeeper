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

ActiveRecord::Schema.define(version: 20200726082241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.decimal "amount", comment: "账户金额"
    t.integer "status", default: 0, comment: "状态"
    t.datetime "deleted_at"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "frozen_amount", default: "0.0", comment: "冻结金额"
    t.index ["deleted_at"], name: "index_accounts_on_deleted_at"
    t.index ["status"], name: "index_accounts_on_status"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "name", comment: "书名"
    t.text "describe", comment: "简介"
    t.string "author", comment: "作者"
    t.string "isbn", comment: "图书版号"
    t.integer "status", default: 0, comment: "状态"
    t.integer "category", comment: "分类"
    t.datetime "issue_at", comment: "发行时间"
    t.datetime "purchase_at", comment: "购入时间"
    t.datetime "deleted_at"
    t.bigint "group_id"
    t.bigint "series_book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "rent", default: "0.0", comment: "租金"
    t.index ["deleted_at"], name: "index_books_on_deleted_at"
    t.index ["group_id"], name: "index_books_on_group_id"
    t.index ["isbn"], name: "index_books_on_isbn"
    t.index ["name"], name: "index_books_on_name"
    t.index ["series_book_id"], name: "index_books_on_series_book_id"
    t.index ["status"], name: "index_books_on_status"
  end

  create_table "check_out_records", force: :cascade do |t|
    t.integer "status", default: 0, comment: "状态"
    t.datetime "lend_at", comment: "借出时间"
    t.datetime "return_at", comment: "归还时间"
    t.datetime "deleted_at"
    t.bigint "user_id"
    t.bigint "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_check_out_records_on_book_id"
    t.index ["deleted_at"], name: "index_check_out_records_on_deleted_at"
    t.index ["lend_at"], name: "index_check_out_records_on_lend_at"
    t.index ["return_at"], name: "index_check_out_records_on_return_at"
    t.index ["status"], name: "index_check_out_records_on_status"
    t.index ["user_id"], name: "index_check_out_records_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_roles_on_deleted_at"
  end

  create_table "series_books", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transition_records", force: :cascade do |t|
    t.decimal "amount", comment: "金额"
    t.integer "transition_type", comment: "转账类型"
    t.string "note", comment: "备注"
    t.datetime "transition_time", comment: "发生时间"
    t.datetime "deleted_at"
    t.bigint "user_id"
    t.bigint "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_transition_records_on_book_id"
    t.index ["deleted_at"], name: "index_transition_records_on_deleted_at"
    t.index ["transition_time"], name: "index_transition_records_on_transition_time"
    t.index ["transition_type"], name: "index_transition_records_on_transition_type"
    t.index ["user_id"], name: "index_transition_records_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", comment: "用户名"
    t.string "sn", comment: "用户编号"
    t.integer "status", default: 0, comment: "状态"
    t.datetime "deleted_at"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["status"], name: "index_users_on_status"
  end

end
