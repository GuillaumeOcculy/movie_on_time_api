class PollSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body

  has_many :answers, serializer: PollAnswerItemSerializer
end
