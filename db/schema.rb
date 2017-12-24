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

ActiveRecord::Schema.define(version: 20171222204913) do

  create_table "access_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "user_name", null: false
    t.string "event", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_access_logs_on_user_id"
  end

  create_table "emails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.string "subject", null: false
    t.text "body", limit: 4294967295
    t.integer "status", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_emails_on_user_id"
  end

  create_table "permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.string "module"
    t.text "description"
    t.integer "status", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "role_id", null: false
    t.bigint "permission_id", null: false
  end

  create_table "recipients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "email_id"
    t.bigint "user_id"
    t.string "status", default: "1"
    t.string "is_read", default: "0"
    t.index ["email_id", "user_id"], name: "index_recipients_on_email_id_and_user_id"
    t.index ["email_id"], name: "index_recipients_on_email_id"
    t.index ["user_id"], name: "index_recipients_on_user_id"
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.text "description"
    t.integer "status", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "user", null: false
    t.string "name", null: false
    t.string "last_name"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "status", default: 1, null: false
    t.string "image"
    t.text "description"
    t.datetime "last_password_change"
    t.string "remember_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
