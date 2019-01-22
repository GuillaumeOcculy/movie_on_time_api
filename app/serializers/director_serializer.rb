class DirectorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
end
