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

ActiveRecord::Schema.define(version: 2021_02_03_192655) do

  create_table "puppet_configurations", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.string "kind"
    t.boolean "multiple_values", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "configurable_type"
    t.integer "configurable_id"
    t.index ["configurable_id", "configurable_type"], name: "index_puppet_configurations_on_configurable"
    t.index ["parent_id"], name: "index_puppet_configurations_on_parent_id"
  end

  create_table "puppet_environments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["slug"], name: "index_puppet_environments_on_slug", unique: true
  end

  create_table "puppet_nodes", force: :cascade do |t|
    t.string "fqdn"
    t.string "role"
    t.bigint "puppet_environment_id", null: false
    t.string "zone"
    t.string "os_family"
    t.string "os_lsbdistcodename"
    t.string "organization"
    t.string "config_file_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.string "name"
    t.index ["puppet_environment_id"], name: "index_puppet_nodes_on_puppet_environment_id"
    t.index ["slug"], name: "index_puppet_nodes_on_slug", unique: true
  end

  create_table "puppet_options", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.integer "puppet_node_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["puppet_node_id"], name: "index_puppet_options_on_puppet_node_id"
    t.index ["slug"], name: "index_puppet_options_on_slug"
  end

  create_table "puppet_values", force: :cascade do |t|
    t.string "value"
    t.string "slug"
    t.integer "puppet_configuration_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["puppet_configuration_id"], name: "index_puppet_values_on_puppet_configuration_id"
    t.index ["slug"], name: "index_puppet_values_on_slug"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.bigint "role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "puppet_nodes", "puppet_environments"
  add_foreign_key "puppet_options", "puppet_nodes"
  add_foreign_key "puppet_values", "puppet_configurations"
  add_foreign_key "users", "roles"
end
