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

ActiveRecord::Schema.define(version: 20140713053516) do

  create_table "groups", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "round_id"
    t.string   "name"
  end

  create_table "groups_teams", force: true do |t|
    t.integer "group_id"
    t.integer "team_id"
  end

  create_table "matchups", force: true do |t|
    t.integer  "home_id"
    t.integer  "away_id"
    t.integer  "homeScore"
    t.integer  "awayScore"
    t.boolean  "final"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "round_id"
  end

  create_table "matchups_stats", id: false, force: true do |t|
    t.integer "matchup_id", null: false
    t.integer "stat_id",    null: false
  end

  create_table "rounds", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stats", force: true do |t|
    t.string   "title",      null: false
    t.string   "key",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.integer  "wins"
    t.integer  "loss"
    t.integer  "ties"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "goals_for"
    t.integer  "goals_against"
    t.integer  "points"
  end

end
