class V1::BaseController < ApplicationController
  include Rails::Pagination

  WillPaginate.per_page = 32

  before_action :authenticate_user

  private
  def invalid_resource!(errors = [])
    api_error(status: 422, errors: errors)
  end

  def api_error(status: 500, errors: [])
    unless Rails.env.production?
      puts errors.full_messages if errors.respond_to? :full_messages
    end
    head status: status and return if errors.empty?

    render json: errors, status: status
  end

  def meta_attributes(collection, extra_meta = {})
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.previous_page, # use collection.previous_page when using will_paginate
      total_pages: collection.total_pages,
      total_count: collection.total_entries
    }.merge(extra_meta)
  end

  def authenticate_token!
    payload = JsonWebToken.decode(auth_token)
    @current_user = User.find(payload['sub'])
  rescue JWT::ExpiredSignature
    render json: {errors: ['Auth token has expired']}, status: :unauthorized
  rescue JWT::DecodeError
    render json: {errors: ['Invalid auth token']}, status: :unauthorized
  end

   def auth_token
    @auth_token ||= request.headers.fetch('Authorization', '').split(' ').last
  end

  def authenticate_user
    return unless auth_token
    authenticate_token!
  end

  def selected_country
    @current_user&.country || 'FR'
  end

  def selected_query
    params[:q] if params[:q].present?
  end

  def latitude
    params[:latitude]
  end

  def longitude
    params[:longitude]
  end

  def save_search
    SearchHistory.create(content: selected_query, controller: controller_name, action: action_name, user: @current_user) if 3 <= (selected_query&.length || 0)
  end
end
