class ShowtimeItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :start_time, :dimension, :language, :version
end
