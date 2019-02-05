class V1::CinemasController < ApplicationController
  def index
    cinemas = Cinema.in_paris
    render json: CinemaItemSerializer.new(cinemas).serialized_json
  end
end
