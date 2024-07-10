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

ActiveRecord::Schema[7.1].define(version: 2024_07_10_140755) do
  create_table "actors", force: :cascade do |t|
    t.string "name", null: false
    t.integer "movies_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movies_id"], name: "index_actors_on_movies_id"
  end

  create_table "directors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "movies_id"
    t.index ["movies_id"], name: "index_directors_on_movies_id"
  end

  create_table "film_locations", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "actor_id"
    t.string "location", null: false
    t.string "country", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actor_id"], name: "index_film_locations_on_actor_id"
    t.index ["movie_id"], name: "index_film_locations_on_movie_id"
  end

  create_table "movies", force: :cascade do |t|
    t.integer "director_id", null: false
    t.string "title", null: false
    t.text "description", null: false
    t.integer "year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reviews_id"
    t.index ["director_id"], name: "index_movies_on_director_id"
    t.index ["reviews_id"], name: "index_movies_on_reviews_id"
    t.index ["title"], name: "index_movies_on_title"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "user_id"
    t.float "rating", null: false
    t.text "comment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_reviews_on_movie_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reviews_id"
    t.index ["reviews_id"], name: "index_users_on_reviews_id"
  end

  add_foreign_key "actors", "movies", column: "movies_id"
  add_foreign_key "directors", "movies", column: "movies_id"
  add_foreign_key "film_locations", "actors"
  add_foreign_key "film_locations", "movies"
  add_foreign_key "movies", "directors"
  add_foreign_key "movies", "reviews", column: "reviews_id"
  add_foreign_key "reviews", "movies"
  add_foreign_key "reviews", "users"
  add_foreign_key "users", "reviews", column: "reviews_id"
end
