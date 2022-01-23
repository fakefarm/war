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

ActiveRecord::Schema.define(version: 20_220_119_155_051) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'characters', force: :cascade do |t|
    t.string 'hero'
    t.string 'legal_name'
    t.string 'description'
    t.integer 'universe_id'
    t.string 'universe'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['hero'], name: 'index_characters_on_hero'
    t.index ['legal_name'], name: 'index_characters_on_legal_name'
  end

  create_table 'combats', force: :cascade do |t|
    t.integer 'seed_number'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'players', force: :cascade do |t|
    t.bigint 'character_id', null: false
    t.bigint 'combat_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['character_id'], name: 'index_players_on_character_id'
    t.index ['combat_id'], name: 'index_players_on_combat_id'
  end

  add_foreign_key 'players', 'characters'
  add_foreign_key 'players', 'combats'
end
