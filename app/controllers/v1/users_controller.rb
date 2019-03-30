class V1::UsersController < V1::BaseController
  def create
    user = User.new(user_params)
    if user.save
      render json: AuthenticatedUserSerializer.new(user).serialized_json, status: :created
    else
      invalid_resource!(user.errors)
    end
  end

  private
  def user_params
    params.permit(:email, :password, :first_name, :last_name)
  end
end
