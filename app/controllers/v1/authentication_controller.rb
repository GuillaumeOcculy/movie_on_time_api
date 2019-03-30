class V1::AuthenticationController < V1::BaseController
  def create
    user = User.find_by(email: params[:email])
    return invalid_resource!(['Invalid email']) unless user

    if user.valid_password? params[:password]
      render json: AuthenticatedUserSerializer.new(user).serialized_json
    else
      invalid_resource!(['Password invalid'])
    end
  end
end
