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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180612011702) do

  create_table "answers", force: :cascade do |t|
    t.text     "content",      limit: 65535
    t.integer  "likes",        limit: 4
    t.integer  "user_id",      limit: 4
    t.integer  "question_id",  limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "is_anonymous", limit: 1
  end

  add_index "answers", ["question_id", "created_at"], name: "index_answers_on_question_id_and_created_at", using: :btree
  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "appointments", force: :cascade do |t|
    t.string   "status",          limit: 255
    t.datetime "date"
    t.integer  "seller_id",       limit: 4
    t.integer  "buyer_id",        limit: 4
    t.integer  "vehicle_id",      limit: 4
    t.integer  "conversation_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "appointments", ["buyer_id", "date"], name: "index_appointments_on_buyer_id_and_date", using: :btree
  add_index "appointments", ["conversation_id"], name: "index_appointments_on_conversation_id", using: :btree
  add_index "appointments", ["vehicle_id"], name: "index_appointments_on_vehicle_id", using: :btree

  create_table "autopart_photos", force: :cascade do |t|
    t.integer  "autopart_id",        limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_index "autopart_photos", ["autopart_id"], name: "index_autopart_photos_on_autopart_id", using: :btree

  create_table "autoparts", force: :cascade do |t|
    t.string   "listing_name",   limit: 255
    t.string   "street_address", limit: 255
    t.string   "apartment",      limit: 255
    t.string   "city",           limit: 255
    t.string   "state",          limit: 255
    t.integer  "price",          limit: 4
    t.text     "summary",        limit: 65535
    t.text     "shipping_info",  limit: 65535
    t.float    "latitude",       limit: 24
    t.float    "longitude",      limit: 24
    t.datetime "bumped_at"
    t.datetime "sold_at"
    t.integer  "user_id",        limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "autoparts", ["user_id", "created_at"], name: "index_autoparts_on_user_id_and_created_at", using: :btree
  add_index "autoparts", ["user_id"], name: "index_autoparts_on_user_id", using: :btree

  create_table "availabilities", force: :cascade do |t|
    t.string   "day",        limit: 255
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "vehicle_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "availabilities", ["vehicle_id"], name: "index_availabilities_on_vehicle_id", using: :btree

  create_table "blogs", force: :cascade do |t|
    t.string   "title",                    limit: 255
    t.text     "content",                  limit: 65535
    t.integer  "user_id",                  limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "cover_photo_file_name",    limit: 255
    t.string   "cover_photo_content_type", limit: 255
    t.integer  "cover_photo_file_size",    limit: 4
    t.datetime "cover_photo_updated_at"
  end

  add_index "blogs", ["user_id"], name: "index_blogs_on_user_id", using: :btree

  create_table "business_hours", force: :cascade do |t|
    t.string   "day",           limit: 255
    t.time     "open_time"
    t.time     "close_time"
    t.boolean  "is_closed",     limit: 1
    t.integer  "dealership_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "business_hours", ["dealership_id"], name: "index_business_hours_on_dealership_id", using: :btree

  create_table "club_product_photos", force: :cascade do |t|
    t.integer  "club_product_id",    limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_index "club_product_photos", ["club_product_id"], name: "index_club_product_photos_on_club_product_id", using: :btree

  create_table "club_products", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "price",         limit: 4
    t.text     "description",   limit: 65535
    t.text     "shipping_info", limit: 65535
    t.integer  "club_id",       limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "club_products", ["club_id"], name: "index_club_products_on_club_id", using: :btree

  create_table "clubs", force: :cascade do |t|
    t.string   "name",                     limit: 255
    t.string   "description",              limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "cover_photo_file_name",    limit: 255
    t.string   "cover_photo_content_type", limit: 255
    t.integer  "cover_photo_file_size",    limit: 4
    t.datetime "cover_photo_updated_at"
    t.string   "city",                     limit: 255
    t.string   "state",                    limit: 255
    t.float    "latitude",                 limit: 24
    t.float    "longitude",                limit: 24
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "next_contributor_id",      limit: 4
    t.boolean  "latest_message_read",      limit: 1
    t.integer  "sender_id",                limit: 4
    t.integer  "recipient_id",             limit: 4
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.boolean  "sender_archived",          limit: 1
    t.boolean  "recipient_archived",       limit: 1
    t.datetime "sender_last_viewed_at"
    t.datetime "recipient_last_viewed_at"
    t.boolean  "is_sender_anonymous",      limit: 1, default: true
  end

  add_index "conversations", ["recipient_id"], name: "fk_rails_f0edaae389", using: :btree
  add_index "conversations", ["sender_id"], name: "fk_rails_2855ab3029", using: :btree

  create_table "dealer_invitations", force: :cascade do |t|
    t.string   "email",         limit: 255
    t.integer  "sender_id",     limit: 4
    t.integer  "dealership_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "dealer_invitations", ["dealership_id", "created_at"], name: "index_dealer_invitations_on_dealership_id_and_created_at", using: :btree
  add_index "dealer_invitations", ["sender_id", "created_at"], name: "index_dealer_invitations_on_sender_id_and_created_at", using: :btree

  create_table "dealerships", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "email",              limit: 255
    t.integer  "user_id",            limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "activation_digest",  limit: 255
    t.boolean  "activated",          limit: 1,   default: false
    t.datetime "activated_at"
    t.string   "description",        limit: 255
    t.string   "website",            limit: 255
    t.string   "sales_phone",        limit: 255
    t.string   "service_phone",      limit: 255
    t.string   "street_address",     limit: 255
    t.string   "building",           limit: 255
    t.string   "city",               limit: 255
    t.string   "state",              limit: 255
    t.float    "latitude",           limit: 24
    t.float    "longitude",          limit: 24
    t.string   "logo_file_name",     limit: 255
    t.string   "logo_content_type",  limit: 255
    t.integer  "logo_file_size",     limit: 4
    t.datetime "logo_updated_at"
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.integer  "photo_file_size",    limit: 4
    t.datetime "photo_updated_at"
  end

  add_index "dealerships", ["user_id"], name: "index_dealerships_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "discussion_comments", force: :cascade do |t|
    t.text     "comment",       limit: 65535
    t.integer  "discussion_id", limit: 4
    t.integer  "user_id",       limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "discussion_comments", ["discussion_id", "created_at"], name: "index_discussion_comments_on_discussion_id_and_created_at", using: :btree
  add_index "discussion_comments", ["discussion_id"], name: "index_discussion_comments_on_discussion_id", using: :btree
  add_index "discussion_comments", ["user_id"], name: "index_discussion_comments_on_user_id", using: :btree

  create_table "discussions", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.text     "content",          limit: 65535
    t.integer  "user_id",          limit: 4
    t.integer  "club_id",          limit: 4
    t.integer  "vehicle_make_id",  limit: 4
    t.integer  "vehicle_model_id", limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "cached_votes_up",  limit: 4,     default: 0
  end

  add_index "discussions", ["cached_votes_up"], name: "index_discussions_on_cached_votes_up", using: :btree
  add_index "discussions", ["club_id", "created_at"], name: "index_discussions_on_club_id_and_created_at", using: :btree
  add_index "discussions", ["club_id"], name: "index_discussions_on_club_id", using: :btree
  add_index "discussions", ["user_id", "created_at"], name: "index_discussions_on_user_id_and_created_at", using: :btree
  add_index "discussions", ["user_id"], name: "index_discussions_on_user_id", using: :btree
  add_index "discussions", ["vehicle_make_id", "created_at"], name: "index_discussions_on_vehicle_make_id_and_created_at", using: :btree
  add_index "discussions", ["vehicle_make_id"], name: "index_discussions_on_vehicle_make_id", using: :btree
  add_index "discussions", ["vehicle_model_id", "created_at"], name: "index_discussions_on_vehicle_model_id_and_created_at", using: :btree
  add_index "discussions", ["vehicle_model_id"], name: "index_discussions_on_vehicle_model_id", using: :btree

  create_table "enquiries", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "email",        limit: 255
    t.string   "phone_number", limit: 255
    t.string   "category",     limit: 255
    t.text     "content",      limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "favorite_autoparts", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "autopart_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "favorite_autoparts", ["autopart_id"], name: "fk_rails_9fd784e187", using: :btree
  add_index "favorite_autoparts", ["user_id", "autopart_id"], name: "index_favorite_autoparts_on_user_id_and_autopart_id", unique: true, using: :btree
  add_index "favorite_autoparts", ["user_id", "created_at"], name: "index_favorite_autoparts_on_user_id_and_created_at", using: :btree

  create_table "favorite_vehicles", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "vehicle_id",    limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "is_liked",      limit: 1
    t.boolean  "is_loved",      limit: 1
    t.boolean  "is_test_drive", limit: 1
    t.boolean  "is_purchase",   limit: 1
  end

  add_index "favorite_vehicles", ["user_id", "created_at"], name: "index_favorite_vehicles_on_user_id_and_created_at", using: :btree
  add_index "favorite_vehicles", ["user_id", "vehicle_id"], name: "index_favorite_vehicles_on_user_id_and_vehicle_id", unique: true, using: :btree
  add_index "favorite_vehicles", ["vehicle_id"], name: "fk_rails_9eea04952a", using: :btree

  create_table "inquiries", force: :cascade do |t|
    t.datetime "date"
    t.integer  "user_id",         limit: 4
    t.integer  "vehicle_id",      limit: 4
    t.integer  "conversation_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "inquiries", ["conversation_id"], name: "index_inquiries_on_conversation_id", using: :btree
  add_index "inquiries", ["user_id", "date"], name: "index_inquiries_on_user_id_and_date", using: :btree
  add_index "inquiries", ["user_id"], name: "index_inquiries_on_user_id", using: :btree
  add_index "inquiries", ["vehicle_id"], name: "index_inquiries_on_vehicle_id", using: :btree

  create_table "invitations", force: :cascade do |t|
    t.string   "email",        limit: 255
    t.string   "token",        limit: 255
    t.integer  "sender_id",    limit: 4
    t.integer  "recipient_id", limit: 4
    t.integer  "club_id",      limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "invitations", ["club_id", "created_at"], name: "index_invitations_on_club_id_and_created_at", using: :btree
  add_index "invitations", ["recipient_id", "created_at"], name: "index_invitations_on_recipient_id_and_created_at", using: :btree
  add_index "invitations", ["sender_id", "created_at"], name: "index_invitations_on_sender_id_and_created_at", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.boolean  "admin",      limit: 1
    t.integer  "user_id",    limit: 4
    t.integer  "club_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "memberships", ["club_id"], name: "fk_rails_2410b5d7e1", using: :btree
  add_index "memberships", ["user_id", "club_id"], name: "index_memberships_on_user_id_and_club_id", unique: true, using: :btree
  add_index "memberships", ["user_id", "created_at"], name: "index_memberships_on_user_id_and_created_at", using: :btree

  create_table "message_photos", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "content",         limit: 65535
    t.integer  "conversation_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.boolean  "received",   limit: 1
    t.integer  "user_id",    limit: 4
    t.integer  "vehicle_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree
  add_index "payments", ["vehicle_id", "created_at"], name: "index_payments_on_vehicle_id_and_created_at", using: :btree
  add_index "payments", ["vehicle_id"], name: "index_payments_on_vehicle_id", using: :btree

  create_table "personalized_searches", force: :cascade do |t|
    t.integer  "price",                       limit: 4
    t.integer  "mileage",                     limit: 4
    t.integer  "year",                        limit: 4
    t.boolean  "is_convertible",              limit: 1
    t.boolean  "is_coupe",                    limit: 1
    t.boolean  "is_crossover",                limit: 1
    t.boolean  "is_hatchback",                limit: 1
    t.boolean  "is_minivan",                  limit: 1
    t.boolean  "is_pickup",                   limit: 1
    t.boolean  "is_sedan",                    limit: 1
    t.boolean  "is_suv",                      limit: 1
    t.boolean  "is_van",                      limit: 1
    t.boolean  "is_wagon",                    limit: 1
    t.boolean  "is_leather_seats",            limit: 1
    t.boolean  "is_sunroof",                  limit: 1
    t.boolean  "is_navigation_system",        limit: 1
    t.boolean  "is_dvd_entertainment_system", limit: 1
    t.boolean  "is_bluetooth",                limit: 1
    t.boolean  "is_backup_camera",            limit: 1
    t.boolean  "is_remote_start",             limit: 1
    t.boolean  "is_tow_package",              limit: 1
    t.integer  "user_id",                     limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "personalized_searches", ["user_id"], name: "index_personalized_searches_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "vehicle_id",         limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "rotation",           limit: 4,   default: 0, null: false
  end

  add_index "photos", ["vehicle_id"], name: "index_photos_on_vehicle_id", using: :btree

  create_table "post_comments", force: :cascade do |t|
    t.string   "content",    limit: 255
    t.integer  "post_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "post_comments", ["post_id", "created_at"], name: "index_post_comments_on_post_id_and_created_at", using: :btree
  add_index "post_comments", ["post_id"], name: "index_post_comments_on_post_id", using: :btree
  add_index "post_comments", ["user_id"], name: "index_post_comments_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "content",            limit: 255
    t.integer  "user_id",            limit: 4
    t.integer  "club_id",            limit: 4
    t.integer  "vehicle_make_id",    limit: 4
    t.integer  "vehicle_model_id",   limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.integer  "photo_file_size",    limit: 4
    t.datetime "photo_updated_at"
    t.integer  "cached_votes_up",    limit: 4,   default: 0
    t.string   "video_url",          limit: 255
  end

  add_index "posts", ["cached_votes_up"], name: "index_posts_on_cached_votes_up", using: :btree
  add_index "posts", ["club_id", "created_at"], name: "index_posts_on_club_id_and_created_at", using: :btree
  add_index "posts", ["club_id"], name: "index_posts_on_club_id", using: :btree
  add_index "posts", ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree
  add_index "posts", ["vehicle_make_id", "created_at"], name: "index_posts_on_vehicle_make_id_and_created_at", using: :btree
  add_index "posts", ["vehicle_make_id"], name: "index_posts_on_vehicle_make_id", using: :btree
  add_index "posts", ["vehicle_model_id", "created_at"], name: "index_posts_on_vehicle_model_id_and_created_at", using: :btree
  add_index "posts", ["vehicle_model_id"], name: "index_posts_on_vehicle_model_id", using: :btree

  create_table "purchases", force: :cascade do |t|
    t.string   "first_name",                   limit: 255
    t.string   "last_name",                    limit: 255
    t.string   "email",                        limit: 255
    t.string   "phone_number",                 limit: 255
    t.string   "billing_first_name",           limit: 255
    t.string   "billing_last_name",            limit: 255
    t.string   "billing_street_address",       limit: 255
    t.string   "billing_apartment",            limit: 255
    t.string   "billing_city",                 limit: 255
    t.string   "billing_state",                limit: 255
    t.string   "education",                    limit: 255
    t.string   "employment",                   limit: 255
    t.string   "employer_name",                limit: 255
    t.string   "employer_phone",               limit: 255
    t.string   "current_title",                limit: 255
    t.string   "residence_type",               limit: 255
    t.integer  "annual_income",                limit: 4
    t.integer  "time_at_job",                  limit: 4
    t.integer  "monthly_payment",              limit: 4
    t.integer  "time_at_address",              limit: 4
    t.boolean  "is_extended_service_contract", limit: 1
    t.boolean  "is_wheel_tire_care",           limit: 1
    t.boolean  "is_ding_dent_care",            limit: 1
    t.boolean  "is_key_replacement",           limit: 1
    t.boolean  "is_resistall_protection",      limit: 1
    t.datetime "date_of_birth"
    t.datetime "processed_at"
    t.integer  "buyer_id",                     limit: 4
    t.integer  "seller_id",                    limit: 4
    t.integer  "vehicle_id",                   limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "purchases", ["buyer_id", "created_at"], name: "index_purchases_on_buyer_id_and_created_at", using: :btree
  add_index "purchases", ["seller_id", "created_at"], name: "index_purchases_on_seller_id_and_created_at", using: :btree
  add_index "purchases", ["vehicle_id"], name: "index_purchases_on_vehicle_id", using: :btree

  create_table "purchases_upgrades", id: false, force: :cascade do |t|
    t.integer "upgrade_id",  limit: 4, null: false
    t.integer "purchase_id", limit: 4, null: false
  end

  add_index "purchases_upgrades", ["purchase_id"], name: "purchases_upgrades_purchase_id_fk", using: :btree
  add_index "purchases_upgrades", ["upgrade_id"], name: "purchases_upgrades_upgrade_id_fk", using: :btree

  create_table "questions", force: :cascade do |t|
    t.text     "content",      limit: 65535
    t.integer  "likes",        limit: 4
    t.datetime "read_at"
    t.integer  "user_id",      limit: 4
    t.integer  "vehicle_id",   limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "is_anonymous", limit: 1
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree
  add_index "questions", ["vehicle_id", "created_at"], name: "index_questions_on_vehicle_id_and_created_at", using: :btree
  add_index "questions", ["vehicle_id"], name: "index_questions_on_vehicle_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.text     "comment",       limit: 65535
    t.integer  "rating",        limit: 4
    t.integer  "reviewer_id",   limit: 4
    t.integer  "reviewed_id",   limit: 4
    t.integer  "vehicle_id",    limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.datetime "read_at"
    t.integer  "dealership_id", limit: 4
  end

  add_index "reviews", ["dealership_id", "created_at"], name: "index_reviews_on_dealership_id_and_created_at", using: :btree
  add_index "reviews", ["dealership_id"], name: "index_reviews_on_dealership_id", using: :btree
  add_index "reviews", ["reviewed_id", "created_at"], name: "index_reviews_on_reviewed_id_and_created_at", using: :btree
  add_index "reviews", ["reviewer_id", "created_at"], name: "index_reviews_on_reviewer_id_and_created_at", using: :btree
  add_index "reviews", ["vehicle_id", "created_at"], name: "index_reviews_on_vehicle_id_and_created_at", using: :btree

  create_table "special_offers", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.integer  "vehicle_id",  limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "special_offers", ["vehicle_id"], name: "index_special_offers_on_vehicle_id", using: :btree

  create_table "upgrades", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "duration",   limit: 4
    t.integer  "price",      limit: 4
    t.integer  "vehicle_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "upgrades", ["vehicle_id"], name: "index_upgrades_on_vehicle_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",          limit: 255
    t.string   "last_name",           limit: 255
    t.string   "email",               limit: 255
    t.boolean  "is_subscribed",       limit: 1
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "password_digest",     limit: 255
    t.string   "remember_digest",     limit: 255
    t.boolean  "admin",               limit: 1,     default: false
    t.string   "activation_digest",   limit: 255
    t.boolean  "activated",           limit: 1,     default: false
    t.datetime "activated_at"
    t.string   "reset_digest",        limit: 255
    t.datetime "reset_sent_at"
    t.string   "provider",            limit: 255
    t.string   "uid",                 limit: 255
    t.string   "phone_number",        limit: 255
    t.string   "residence",           limit: 255
    t.string   "school",              limit: 255
    t.string   "work",                limit: 255
    t.text     "description",         limit: 65535
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
    t.string   "stripe_id",           limit: 255
    t.string   "merchant_id",         limit: 255
    t.integer  "dealership_id",       limit: 4
    t.boolean  "dealership_admin",    limit: 1,     default: false
    t.string   "dealer_position",     limit: 255
    t.integer  "industry_experience", limit: 4
  end

  add_index "users", ["dealership_id"], name: "users_dealership_id_fk", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "vehicle_makes", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "cover_photo_url", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "vehicle_models", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "vehicle_make_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "vehicle_models", ["vehicle_make_id"], name: "index_vehicle_models_on_vehicle_make_id", using: :btree

  create_table "vehicles", force: :cascade do |t|
    t.string   "body_style",                  limit: 255
    t.string   "color",                       limit: 255
    t.string   "transmission",                limit: 255
    t.string   "fuel_type",                   limit: 255
    t.string   "drivetrain",                  limit: 255
    t.string   "vin",                         limit: 255
    t.string   "listing_name",                limit: 255
    t.string   "street_address",              limit: 255
    t.string   "apartment",                   limit: 255
    t.string   "city",                        limit: 255
    t.string   "state",                       limit: 255
    t.integer  "year",                        limit: 4
    t.integer  "price",                       limit: 4
    t.integer  "mileage",                     limit: 4
    t.integer  "seating_capacity",            limit: 4
    t.text     "summary",                     limit: 65535
    t.text     "sellers_notes",               limit: 65535
    t.boolean  "is_leather_seats",            limit: 1
    t.boolean  "is_sunroof",                  limit: 1
    t.boolean  "is_navigation_system",        limit: 1
    t.boolean  "is_dvd_entertainment_system", limit: 1
    t.boolean  "is_bluetooth",                limit: 1
    t.boolean  "is_backup_camera",            limit: 1
    t.boolean  "is_remote_start",             limit: 1
    t.boolean  "is_tow_package",              limit: 1
    t.integer  "user_id",                     limit: 4
    t.integer  "vehicle_make_id",             limit: 4
    t.integer  "vehicle_model_id",            limit: 4
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.float    "latitude",                    limit: 24
    t.float    "longitude",                   limit: 24
    t.datetime "sold_at"
    t.datetime "bumped_at"
    t.datetime "posted_at"
    t.integer  "dealership_id",               limit: 4
  end

  add_index "vehicles", ["dealership_id", "created_at"], name: "index_vehicles_on_dealership_id_and_created_at", using: :btree
  add_index "vehicles", ["dealership_id"], name: "index_vehicles_on_dealership_id", using: :btree
  add_index "vehicles", ["user_id", "created_at"], name: "index_vehicles_on_user_id_and_created_at", using: :btree
  add_index "vehicles", ["user_id"], name: "index_vehicles_on_user_id", using: :btree
  add_index "vehicles", ["vehicle_make_id"], name: "index_vehicles_on_vehicle_make_id", using: :btree
  add_index "vehicles", ["vehicle_model_id"], name: "index_vehicles_on_vehicle_model_id", using: :btree

  create_table "votes", force: :cascade do |t|
    t.boolean  "vote_flag",    limit: 1
    t.string   "vote_scope",   limit: 255
    t.integer  "vote_weight",  limit: 4
    t.integer  "votable_id",   limit: 4
    t.string   "votable_type", limit: 255
    t.integer  "voter_id",     limit: 4
    t.string   "voter_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "questions", name: "answers_question_id_fk"
  add_foreign_key "answers", "users"
  add_foreign_key "answers", "users", name: "answers_user_id_fk"
  add_foreign_key "appointments", "conversations"
  add_foreign_key "appointments", "conversations", name: "appointments_conversation_id_fk"
  add_foreign_key "appointments", "users", column: "buyer_id"
  add_foreign_key "appointments", "users", column: "buyer_id", name: "appointments_buyer_id_fk"
  add_foreign_key "appointments", "vehicles"
  add_foreign_key "appointments", "vehicles", name: "appointments_vehicle_id_fk"
  add_foreign_key "autopart_photos", "autoparts"
  add_foreign_key "autopart_photos", "autoparts", name: "autopart_photos_autopart_id_fk"
  add_foreign_key "autoparts", "users"
  add_foreign_key "availabilities", "vehicles"
  add_foreign_key "blogs", "users"
  add_foreign_key "business_hours", "dealerships"
  add_foreign_key "club_product_photos", "club_products"
  add_foreign_key "club_products", "clubs"
  add_foreign_key "conversations", "users", column: "recipient_id"
  add_foreign_key "conversations", "users", column: "sender_id"
  add_foreign_key "dealer_invitations", "dealerships"
  add_foreign_key "dealer_invitations", "users", column: "sender_id"
  add_foreign_key "dealerships", "users"
  add_foreign_key "discussion_comments", "discussions"
  add_foreign_key "discussion_comments", "users"
  add_foreign_key "discussions", "clubs"
  add_foreign_key "discussions", "users"
  add_foreign_key "discussions", "vehicle_makes"
  add_foreign_key "discussions", "vehicle_models"
  add_foreign_key "favorite_autoparts", "autoparts"
  add_foreign_key "favorite_autoparts", "users"
  add_foreign_key "favorite_vehicles", "users"
  add_foreign_key "favorite_vehicles", "vehicles"
  add_foreign_key "inquiries", "conversations"
  add_foreign_key "inquiries", "users"
  add_foreign_key "inquiries", "vehicles"
  add_foreign_key "invitations", "clubs"
  add_foreign_key "invitations", "users", column: "recipient_id"
  add_foreign_key "invitations", "users", column: "sender_id"
  add_foreign_key "memberships", "clubs"
  add_foreign_key "memberships", "users"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "payments", "users"
  add_foreign_key "payments", "vehicles"
  add_foreign_key "personalized_searches", "users"
  add_foreign_key "photos", "vehicles"
  add_foreign_key "post_comments", "posts"
  add_foreign_key "post_comments", "users"
  add_foreign_key "posts", "clubs"
  add_foreign_key "posts", "users"
  add_foreign_key "posts", "vehicle_makes"
  add_foreign_key "posts", "vehicle_models"
  add_foreign_key "purchases", "users", column: "buyer_id"
  add_foreign_key "purchases", "users", column: "seller_id"
  add_foreign_key "purchases", "vehicles"
  add_foreign_key "purchases_upgrades", "purchases", name: "purchases_upgrades_purchase_id_fk"
  add_foreign_key "purchases_upgrades", "upgrades", name: "purchases_upgrades_upgrade_id_fk"
  add_foreign_key "questions", "users"
  add_foreign_key "questions", "vehicles"
  add_foreign_key "reviews", "dealerships"
  add_foreign_key "reviews", "users", column: "reviewed_id"
  add_foreign_key "reviews", "users", column: "reviewer_id"
  add_foreign_key "reviews", "vehicles"
  add_foreign_key "special_offers", "vehicles"
  add_foreign_key "upgrades", "vehicles"
  add_foreign_key "users", "dealerships", name: "users_dealership_id_fk"
  add_foreign_key "vehicle_models", "vehicle_makes"
  add_foreign_key "vehicles", "dealerships"
  add_foreign_key "vehicles", "users"
  add_foreign_key "vehicles", "vehicle_makes"
  add_foreign_key "vehicles", "vehicle_models"
end
