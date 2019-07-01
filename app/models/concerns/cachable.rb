module Cachable
  extend ActiveSupport::Concern

  included do
  end

  class_methods do
    def live_cached
      Rails.cache.fetch('movies_live') do 
        ids = Movie.live.joins(:showtimes).have_images.pluck(:id).uniq
        Movie.where(id: ids).recent
      end
    end

    def upcoming_cached
      Rails.cache.fetch('movies_upcoming') do 
        ids = Movie.upcoming.pluck(:id).uniq
        Movie.where(id: ids).old
      end
    end

    def premiere_cached
      Rails.cache.fetch('movies_premiere') do 
        ids = Movie.premiere.pluck(:id).uniq
        Movie.where(id: ids).sort_by_showtime_date
      end
    end

    def reprojection_cached
      Rails.cache.fetch('movies_reprojection') do 
        ids = Movie.reprojection.pluck(:id).uniq
        Movie.where(id: ids).sort_by_showtime_date
      end
    end
  end
end
