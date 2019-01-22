class V1::MoviesController < ApplicationController
  def index
    movies = Movie.live
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
    movie = Movie.find(params[:id])
    render json: MovieSerializer.new(movie, include: [:directors, :casts, :trailers, :genres]).serialized_json
  end
end
