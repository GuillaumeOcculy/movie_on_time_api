class MovieItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :poster_url, :thumbnail_url, :release_date
end
