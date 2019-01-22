class MovieItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :poster_url, :thumbnail_url, :release_date
end
