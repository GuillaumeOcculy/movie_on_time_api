class CastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
end
