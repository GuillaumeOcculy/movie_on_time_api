class CinemaItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :street, :post_code, :city, :ugc_unlimited?

  attribute :favorited do |object, params|
    object.favorited?(params[:current_user])
  end
end
