class V1::PollAnswersController < V1::BaseController
  def create
    param! :poll_id, Integer

    poll = Poll.find_by(id: params[:poll_id]) || Poll.first
    return api_error(status: 404, errors: ['Poll does not exist']) unless poll

    return api_error(status: 422, errors: ['You already answered to this poll']) if @current_user && @current_user.polls_answered.find_by(id: poll.id)

    answer = poll.answers.find_or_initialize_by(body: params[:body])

    if answer.save
      @current_user.poll_votes.create(poll_answer: answer)
      answer.update(vote_count: answer.poll_votes.size)
    else
      invalid_resource!(answer.errors)
    end

    render json: PollSerializer.new(poll, include: [:answers]), status: :created
  end

  private

  def vote_params
    params.permit(:body)
  end
end
