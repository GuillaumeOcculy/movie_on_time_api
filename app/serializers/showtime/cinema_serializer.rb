class Showtime::CinemaSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :street, :post_code, :city, :latitude, :longitude, :ugc_unlimited?
end
