class SaveNewMoviesWorker
  include Sidekiq::Worker

  def perform(query)
    SaveNewMoviesService.new(query).perform
  end
end
