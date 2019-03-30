class AuthenticatedUserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :email, :token
end
