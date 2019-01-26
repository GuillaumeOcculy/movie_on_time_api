class Showtime::MovieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :poster_url, :thumbnail_url, :running_time, :release_date

  attribute :casts do |object|
    CastSerializer.new(object.casts).serializable_hash
  end

  attribute :directors do |object|
    DirectorSerializer.new(object.directors).serializable_hash
  end
end
