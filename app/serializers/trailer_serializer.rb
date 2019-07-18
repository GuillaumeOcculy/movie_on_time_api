class TrailerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :url, :language
end
