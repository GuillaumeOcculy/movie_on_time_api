class AnswerToPollService
  def initialize(params, current_user)
    @params = params
    @current_user = current_user
    @errors = []
  end

  def perform
    find_poll(@params[:poll_id])

    # if user is not logged in, save as guest user and vote
    unless @current_user
      @errors << 'You must enter an email' if @params[:email].blank?
      @errors << 'You must log in with this email to vote' if User.find_by(email: @params[:email])

      return OpenStruct.new(success?: false, poll: nil, errors: @errors) if @errors.any?

      @current_user = User.create!(email: @params[:email], password: Devise.friendly_token.first(8), role: :guest)
    end

    @errors << 'You have already answered to this poll' if @current_user && @current_user.polls_answered.find_by(id: @poll.id)
    return OpenStruct.new(success?: false, poll: nil, errors: @errors) if @errors.any?

    answer = @poll.answers.find_or_initialize_by(body: @params[:body])

    if answer.save
      @current_user.poll_votes.create(poll_answer: answer)
      answer.update(vote_count: answer.poll_votes.size)
    else
      OpenStruct.new(success?: false, poll: nil, errors: answer.errors)
    end

    OpenStruct.new(success?: true, poll: @poll, errors: nil)
  end

  private
  def find_poll(poll_id)
    @poll ||= Poll.find_by(id: poll_id) || Poll.first
    @errors << 'Poll does not exist' unless @poll
    # OpenStruct.new(success?: false, user: nil, errors: @errors)
  end
end
