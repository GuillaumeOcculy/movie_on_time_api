class V1::PollAnswersController < V1::BaseController
  def create
    param! :poll_id, Integer
    param! :email, String
    param! :body, String

    result = AnswerToPollService.new(params, @current_user).perform

    if result.success?
      render json: PollSerializer.new(result.poll, include: [:answers]), status: :created
    else
      invalid_resource!(result.errors)
    end
  end

  private

  def vote_params
    params.permit(:body)
  end
end
