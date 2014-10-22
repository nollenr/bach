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

ActiveRecord::Schema.define(version: 20141022160314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "file_extensions", force: true do |t|
    t.string   "extension",                   null: false
    t.boolean  "process_tag", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort_order"
    t.string   "description"
  end

  add_index "file_extensions", ["extension"], name: "index_file_extensions_on_extension", unique: true, using: :btree

  create_table "libraries", force: true do |t|
    t.integer  "idofparent"
    t.string   "name",                          null: false
    t.boolean  "isroot",        default: false, null: false
    t.boolean  "isleaf",        default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ismaster",      default: false, null: false
    t.boolean  "newlibraryrec", default: true,  null: false
  end

  create_table "library_file_specs", force: true do |t|
    t.integer  "idoflibraryrecord"
    t.integer  "filesizeinmb"
    t.string   "artist"
    t.string   "album"
    t.decimal  "length"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comment"
    t.string   "genre"
    t.string   "title"
    t.integer  "track"
    t.string   "year"
    t.integer  "bitrate"
    t.integer  "channels"
    t.integer  "sample_rate"
    t.string   "file_extension",                    null: false
    t.integer  "library_priority",                  null: false
    t.boolean  "ismaster",          default: false, null: false
    t.boolean  "newlibraryrec",     default: true,  null: false
  end

  add_index "library_file_specs", ["artist", "album", "title"], name: "index_library_file_specs_on_artist_and_album_and_title", using: :btree
  add_index "library_file_specs", ["idoflibraryrecord"], name: "index_library_file_specs_on_idoflibraryrecord", unique: true, using: :btree

  create_table "library_roots", force: true do |t|
    t.string   "name",                       null: false
    t.integer  "priority",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ismaster",   default: false, null: false
  end

  add_index "library_roots", ["name"], name: "index_library_roots_on_name", unique: true, using: :btree

  create_table "master_library_files", force: true do |t|
    t.integer  "idoflibraryrecord"
    t.integer  "idoflibaryfilespecrecord"
    t.integer  "filesizeinmb"
    t.string   "artist"
    t.string   "album"
    t.decimal  "length"
    t.string   "comment"
    t.string   "genre"
    t.string   "title"
    t.integer  "track"
    t.string   "year"
    t.integer  "bitrate"
    t.integer  "channels"
    t.integer  "sample_rate"
    t.string   "file_extension"
    t.integer  "library_priority"
    t.string   "original_directory_location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "master_library_files", ["artist", "album", "title"], name: "index_master_library_files_on_artist_and_album_and_title", unique: true, using: :btree

end
