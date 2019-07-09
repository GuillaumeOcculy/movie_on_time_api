class PollAnswerItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :vote_count
end
