class V1::MoviesController < ApplicationController
  def index
    movies = Movie.live
    render json: MovieItemSerializer.new(movies).serialized_json
  end
end
