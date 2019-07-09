class V1::PollsController < V1::BaseController
  def show
    poll = Poll.find_by(id: params[:id]) || Poll.first
    render json: PollSerializer.new(poll, include: [:answers])
  end
end
