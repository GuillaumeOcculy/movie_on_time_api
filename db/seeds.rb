# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



cinema_ids = Cinema.in_paris.ids

Showtime.where(cinema_id: cinema_ids).each do |showtime|
  showtime.update(start_at: showtime.start_at + 3.months, start_date: showtime.start_date)
end

movie_ids = MovieCountry.upcoming.pluck(:movie_id)

bercy = Cinema.search('bercy').last

country = Country.find_or_create_by(name: 'France', iso_code: 'FR', language: 'fr')


Movie.where(id: movie_ids).each do |movie|
  date = Time.current + [5,6,7,8,9,10].sample.days
  bercy.showtimes.find_or_create_by!(external_id: "#{movie.id}00000001" , movie: movie) do |new_showtime|
    new_showtime.start_at = date.in_time_zone('Paris').strftime("%Y-%m-%dT%H:%M:00")
    new_showtime.start_date = new_showtime.start_at.to_date
    new_showtime.end_at = new_showtime.start_at + movie.running_time * 60 if movie.running_time
    new_showtime.language = 'fr'
    new_showtime.subtitle_language = 'fr'
    new_showtime.dimension = ['2D', '3D'].sample
    new_showtime.country_code = country.iso_code
  end
end

