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

ActiveRecord::Schema.define(version: 2019_08_29_213536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "casts", force: :cascade do |t|
    t.bigint "movie_id"
    t.bigint "person_id"
    t.string "external_id"
    t.string "name"
    t.string "character"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_casts_on_movie_id"
    t.index ["person_id"], name: "index_casts_on_person_id"
  end

  create_table "chain_countries", force: :cascade do |t|
    t.bigint "chain_id"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chain_id"], name: "index_chain_countries_on_chain_id"
    t.index ["country_id"], name: "index_chain_countries_on_country_id"
  end

  create_table "chains", force: :cascade do |t|
    t.string "external_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cinemas", force: :cascade do |t|
    t.bigint "chain_id"
    t.bigint "country_id"
    t.string "external_id"
    t.string "name"
    t.string "phone"
    t.string "street"
    t.string "house"
    t.string "post_code"
    t.string "city"
    t.string "state"
    t.string "state_abbr"
    t.string "country_code"
    t.float "latitude"
    t.float "longitude"
    t.string "booking_type"
    t.string "website"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chain_id"], name: "index_cinemas_on_chain_id"
    t.index ["country_code"], name: "index_cinemas_on_country_code"
    t.index ["country_id"], name: "index_cinemas_on_country_id"
    t.index ["latitude", "longitude"], name: "index_cinemas_on_latitude_and_longitude"
  end

  create_table "cities", force: :cascade do |t|
    t.bigint "country_id"
    t.string "external_id"
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.string "country_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_cities_on_country_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "iso_code"
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "directors", force: :cascade do |t|
    t.bigint "movie_id"
    t.bigint "person_id"
    t.string "external_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_directors_on_movie_id"
    t.index ["person_id"], name: "index_directors_on_person_id"
  end

  create_table "favorite_cinemas", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "cinema_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cinema_id"], name: "index_favorite_cinemas_on_cinema_id"
    t.index ["user_id"], name: "index_favorite_cinemas_on_user_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "external_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movie_countries", force: :cascade do |t|
    t.bigint "movie_id"
    t.bigint "country_id"
    t.date "release_date"
    t.string "iso_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_movie_countries_on_country_id"
    t.index ["iso_code", "release_date"], name: "index_movie_countries_on_iso_code_and_release_date"
    t.index ["movie_id", "iso_code"], name: "index_movie_countries_on_movie_id_and_iso_code"
    t.index ["movie_id"], name: "index_movie_countries_on_movie_id"
    t.index ["release_date"], name: "index_movie_countries_on_release_date"
  end

  create_table "movie_genres", force: :cascade do |t|
    t.bigint "movie_id"
    t.bigint "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_movie_genres_on_genre_id"
    t.index ["movie_id"], name: "index_movie_genres_on_movie_id"
  end

  create_table "movie_translations", force: :cascade do |t|
    t.bigint "movie_id"
    t.string "language"
    t.string "title"
    t.string "synopsis"
    t.string "poster_url"
    t.string "thumbnail_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_movie_translations_on_movie_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "external_id"
    t.string "original_title"
    t.string "original_language"
    t.string "imdb_id"
    t.string "tmdb_id"
    t.string "rentrak_film_id"
    t.integer "running_time"
    t.string "status"
    t.string "website"
    t.string "backdrop_url"
    t.string "backdrop_min_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "during_credits"
    t.string "after_credits"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "recipient_id"
    t.string "actorable_type"
    t.bigint "actorable_id"
    t.string "notifiable_type"
    t.bigint "notifiable_id"
    t.datetime "read_at"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actorable_type", "actorable_id"], name: "index_notifications_on_actorable_type_and_actorable_id"
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable_type_and_notifiable_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "external_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "poll_answers", force: :cascade do |t|
    t.bigint "poll_id"
    t.text "body", null: false
    t.integer "vote_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poll_id"], name: "index_poll_answers_on_poll_id"
  end

  create_table "poll_votes", force: :cascade do |t|
    t.bigint "poll_answer_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poll_answer_id"], name: "index_poll_votes_on_poll_answer_id"
    t.index ["user_id"], name: "index_poll_votes_on_user_id"
  end

  create_table "polls", force: :cascade do |t|
    t.integer "creator_id"
    t.text "body", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "movie_id"
    t.string "name"
    t.decimal "value"
    t.integer "vote_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_ratings_on_movie_id"
  end

  create_table "search_histories", force: :cascade do |t|
    t.bigint "user_id"
    t.string "content"
    t.string "controller"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_search_histories_on_user_id"
  end

  create_table "showtimes", force: :cascade do |t|
    t.bigint "cinema_id"
    t.bigint "movie_id"
    t.string "external_id"
    t.date "start_date"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string "language"
    t.string "subtitle_language"
    t.string "auditorium"
    t.string "dimension", default: "2D"
    t.string "country_code"
    t.string "booking_type"
    t.string "booking_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cinema_id", "country_code"], name: "index_showtimes_on_cinema_id_and_country_code"
    t.index ["cinema_id"], name: "index_showtimes_on_cinema_id"
    t.index ["movie_id", "country_code"], name: "index_showtimes_on_movie_id_and_country_code"
    t.index ["movie_id", "start_at"], name: "index_showtimes_on_movie_id_and_start_at"
    t.index ["movie_id"], name: "index_showtimes_on_movie_id"
  end

  create_table "trailers", force: :cascade do |t|
    t.bigint "movie_id"
    t.string "language"
    t.string "format"
    t.string "transfert"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_trailers_on_movie_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "settings", default: "{}", null: false
    t.integer "role", default: 1
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "watched_movies", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "movie_id"
    t.date "watched_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_watched_movies_on_movie_id"
    t.index ["user_id"], name: "index_watched_movies_on_user_id"
  end

  create_table "watchlist_movies", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_watchlist_movies_on_movie_id"
    t.index ["user_id"], name: "index_watchlist_movies_on_user_id"
  end

  add_foreign_key "casts", "movies"
  add_foreign_key "casts", "people"
  add_foreign_key "chain_countries", "chains"
  add_foreign_key "chain_countries", "countries"
  add_foreign_key "cinemas", "chains"
  add_foreign_key "cinemas", "countries"
  add_foreign_key "cities", "countries"
  add_foreign_key "directors", "movies"
  add_foreign_key "directors", "people"
  add_foreign_key "favorite_cinemas", "cinemas"
  add_foreign_key "favorite_cinemas", "users"
  add_foreign_key "movie_countries", "countries"
  add_foreign_key "movie_countries", "movies"
  add_foreign_key "movie_genres", "genres"
  add_foreign_key "movie_genres", "movies"
  add_foreign_key "movie_translations", "movies"
  add_foreign_key "poll_votes", "poll_answers"
  add_foreign_key "poll_votes", "users"
  add_foreign_key "ratings", "movies"
  add_foreign_key "search_histories", "users"
  add_foreign_key "showtimes", "cinemas"
  add_foreign_key "showtimes", "movies"
  add_foreign_key "trailers", "movies"
  add_foreign_key "watched_movies", "movies"
  add_foreign_key "watched_movies", "users"
  add_foreign_key "watchlist_movies", "movies"
  add_foreign_key "watchlist_movies", "users"
end
