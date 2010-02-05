# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090608112554) do

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "model"
    t.string   "serial_number"
    t.string   "barcode"
    t.string   "category"
    t.string   "manufacturer"
    t.string   "assigned_to"
    t.string   "date_of_reception"
    t.string   "location"
    t.string   "project_name"
    t.integer  "created_by"
    t.integer  "quantity"
    t.integer  "updated_by"
    t.integer  "voided"
    t.integer  "voided_by"
    t.text     "void_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "role"
    t.string   "description"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "voided"
    t.integer  "voided_by"
    t.text     "void_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.integer  "item_id"
    t.string   "message"
    t.string   "reason"
    t.string   "assigned_to"
    t.string   "location"
    t.string   "storage_code"
    t.string   "item_condition"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "voided"
    t.integer  "voided_by"
    t.text     "void_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "encrypted_password"
    t.string   "salt"
    t.integer  "role"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "voided"
    t.integer  "voided_by"
    t.text     "void_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
