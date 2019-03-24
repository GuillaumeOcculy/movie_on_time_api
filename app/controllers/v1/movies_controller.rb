class V1::MoviesController < ApplicationController
  def index
    movies = Movie.live.joins(:showtimes)
    render json: MovieItemSerializer.new(movies).serialized_json
  end

  def upcoming
    movies = Movie.upcoming
    render json: MovieItemSerializer.new(movies).serialized_json
  end

  def premiere
    movies = Movie.premiere
    render json: MovieItemSerializer.new(movies).serialized_json
  end

  def reprojection
    movies = Movie.reprojection
    render json: MovieItemSerializer.new(movies).serialized_json
  end

  def show
    param! :date, Date, blank: true
    param! :query, String

    movie = Movie.find(params[:id])
    date = params[:date] || movie.first_live_showtime&.start_date
    render json: MovieSerializer.new(movie, params: {movie_id: movie.id, date: date, query: params[:query]}, include: [:directors, :casts, :trailers, :genres, :cinemas]).serialized_json
  end
end
