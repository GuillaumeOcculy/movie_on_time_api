class V1::PollAnswersController < V1::BaseController
  def create
    param! :poll_id, Integer
    param! :email, String
    param! :body, String

    poll = Poll.find_by(id: params[:poll_id]) || Poll.first
    return api_error(status: 404, errors: ['Poll does not exist']) unless poll

    # if user is not logged in, save as guest user and vote
    unless @current_user
      return invalid_resource!(['You must enter an email']) if params[:email].blank?
      return invalid_resource!(['You must log in with this email to vote']) if User.find_by(email: params[:email])

      @current_user = User.create!(email: params[:email], password: Devise.friendly_token.first(8), role: :guest)
    end

    return invalid_resource!(['You have already answered to this poll']) if @current_user && @current_user.polls_answered.find_by(id: poll.id)

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
