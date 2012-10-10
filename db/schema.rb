# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120923121513) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "addons", :force => true do |t|
    t.string   "name"
    t.string   "title_key"
    t.string   "description_key"
    t.string   "invoice_line_key"
    t.decimal  "per_booking_price", :precision => 10, :scale => 2
    t.decimal  "per_night_price",   :precision => 10, :scale => 2
    t.integer  "activated",                                        :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "boat_attribute_standard_values", :force => true do |t|
    t.string   "value"
    t.integer  "boat_attribute_id"
    t.integer  "standard_attribute_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "boat_attribute_standard_values", ["boat_attribute_id"], :name => "index_boat_attribute_standard_values_on_boat_attribute_id"
  add_index "boat_attribute_standard_values", ["standard_attribute_id"], :name => "index_boat_attribute_standard_values_on_standard_attribute_id"

  create_table "boat_attributes", :force => true do |t|
    t.string   "description"
    t.string   "value"
    t.integer  "boat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "boat_attributes", ["boat_id"], :name => "index_boat_attributes_on_boat_id"

  create_table "boat_avail_prices", :force => true do |t|
    t.integer  "boat_id"
    t.date     "period_start"
    t.date     "period_end"
    t.integer  "period_price"
    t.integer  "period_nights"
    t.string   "calc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "boat_avail_prices", ["boat_id"], :name => "index_boat_avail_prices_on_boat_id"

  create_table "boat_model_matches", :force => true do |t|
    t.string   "matcher"
    t.integer  "boat_model_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "boat_model_matches", ["boat_model_id"], :name => "index_boat_model_matches_on_boat_model_id"

  create_table "boat_models", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "boat_reservations", :force => true do |t|
    t.integer  "trip_id"
    t.integer  "boat_id"
    t.integer  "status"
    t.string   "externalref"
    t.datetime "rentaltimestart"
    t.datetime "rentaltimeend"
    t.integer  "rentalmarinastart_id"
    t.integer  "rentalmarinaend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "boat_reservations", ["trip_id"], :name => "index_boat_reservations_on_trip_id"

  create_table "boats", :force => true do |t|
    t.string   "supplier_guid"
    t.integer  "supplier_id"
    t.string   "name"
    t.string   "model_name"
    t.integer  "model_year"
    t.string   "description"
    t.integer  "supplier_marina_id"
    t.integer  "principal_id"
    t.integer  "boat_model_id"
    t.integer  "activated",          :default => 0
    t.string   "hull"
    t.integer  "length_ft"
    t.integer  "cabins"
    t.integer  "berths"
    t.integer  "heads"
    t.integer  "max_persons"
    t.integer  "fuel_capacity"
    t.integer  "water_capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  add_index "boats", ["boat_model_id"], :name => "index_boats_on_boat_model_id"
  add_index "boats", ["permalink"], :name => "index_boats_on_permalink"
  add_index "boats", ["principal_id"], :name => "index_boats_on_principal_id"
  add_index "boats", ["supplier_id"], :name => "index_boats_on_supplier_id"
  add_index "boats", ["supplier_marina_id"], :name => "index_boats_on_supplier_marina_id"

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "isocode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activated",  :default => 1
  end

  create_table "customers", :force => true do |t|
    t.string   "namefirst"
    t.string   "namelast"
    t.string   "address1"
    t.string   "address2"
    t.string   "zipcode"
    t.string   "town"
    t.string   "state"
    t.integer  "country_id"
    t.string   "email"
    t.string   "cellnumber"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoice_lines", :force => true do |t|
    t.integer  "invoice_id"
    t.string   "description"
    t.integer  "duecount"
    t.decimal  "dueamount",   :precision => 10, :scale => 2
    t.decimal  "duevat",      :precision => 10, :scale => 2
    t.decimal  "duetotal",    :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoice_lines", ["invoice_id"], :name => "index_invoice_lines_on_invoice_id"

  create_table "invoices", :force => true do |t|
    t.integer  "trip_id"
    t.string   "identifier"
    t.string   "currency"
    t.integer  "status"
    t.decimal  "due_amount", :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoices", ["trip_id"], :name => "index_invoices_on_trip_id"

  create_table "marinas", :force => true do |t|
    t.string   "name"
    t.decimal  "latitude",   :precision => 15, :scale => 10
    t.decimal  "longitude",  :precision => 15, :scale => 10
    t.string   "address"
    t.integer  "country_id"
    t.integer  "activated",                                  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "marinas", ["country_id"], :name => "index_marinas_on_country_id"

  create_table "marinas_regions", :id => false, :force => true do |t|
    t.integer  "region_id"
    t.integer  "marina_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_customs", :force => true do |t|
    t.string   "url"
    t.string   "redirect"
    t.string   "title"
    t.string   "metadescription"
    t.string   "metakeywords"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.integer  "invoice_id"
    t.string   "psp"
    t.string   "externalref"
    t.decimal  "amount",      :precision => 10, :scale => 2
    t.string   "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["invoice_id"], :name => "index_payments_on_invoice_id"

  create_table "pictures", :force => true do |t|
    t.string   "url"
    t.integer  "width"
    t.integer  "height"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "pictures", ["imageable_type", "imageable_id"], :name => "index_pictures_on_imageable_type_and_imageable_id"

  create_table "principals", :force => true do |t|
    t.string   "name"
    t.string   "supplier_guid"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "notificationemail"
  end

  add_index "principals", ["supplier_id"], :name => "index_principals_on_supplier_id"

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activated",  :default => 1
  end

  create_table "standard_attribute_matches", :force => true do |t|
    t.string   "matcher"
    t.integer  "standard_attribute_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "standard_attribute_matches", ["standard_attribute_id"], :name => "index_standard_attribute_matches_on_standard_attribute_id"

  create_table "standard_attributes", :force => true do |t|
    t.string   "description"
    t.string   "valuetype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_marinas", :force => true do |t|
    t.string   "name"
    t.decimal  "latitude",      :precision => 15, :scale => 10
    t.decimal  "longitude",     :precision => 15, :scale => 10
    t.string   "address"
    t.integer  "country_id"
    t.integer  "marina_id"
    t.string   "supplier_guid"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supplier_marinas", ["country_id"], :name => "index_supplier_marinas_on_country_id"
  add_index "supplier_marinas", ["marina_id"], :name => "index_supplier_marinas_on_marina_id"
  add_index "supplier_marinas", ["supplier_id"], :name => "index_supplier_marinas_on_supplier_id"

  create_table "suppliers", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "suppliers", ["access_token"], :name => "index_suppliers_on_access_token"

  create_table "translations", :force => true do |t|
    t.string   "locale"
    t.string   "key"
    t.text     "value"
    t.text     "interpolations"
    t.boolean  "is_proc",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trips", :force => true do |t|
    t.string   "identifier"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "principal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
