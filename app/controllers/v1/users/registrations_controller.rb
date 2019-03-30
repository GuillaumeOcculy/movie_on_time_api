class V1::Users::RegistrationsController < Devise::RegistrationsController
  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      invalid_resource!(user.errors)
    end
  end


  private
  def user_params
    params.permit(:email, :password, :first_name, :last_name)
  end
end
