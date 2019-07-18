class ShowtimeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :start_time, :end_time, :start_date, :version, :dimension, :booking_link

  attribute :cinema do |object|
    Showtime::CinemaSerializer.new(object.cinema).serializable_hash
  end

  attribute :movie do |object|
    Showtime::MovieSerializer.new(object.movie).serializable_hash
  end
end
