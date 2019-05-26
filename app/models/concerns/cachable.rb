module Cachable
  extend ActiveSupport::Concern

  included do
  end

  class_methods do
    def live_cached
      Rails.cache.fetch('movies_live') do 
        ids = Movie.live.joins(:showtimes).pluck(:id).uniq
        Movie.where(id: ids)
      end
    end

    def upcoming_cached
      Rails.cache.fetch('movies_upcoming') do 
        ids = Movie.upcoming.pluck(:id).uniq
        Movie.where(id: ids)
      end
    end

    def premiere_cached
      Rails.cache.fetch('movies_premiere') do 
        ids = Movie.premiere.pluck(:id).uniq
        Movie.where(id: ids)
      end
    end

    def reprojection_cached
      Rails.cache.fetch('movies_reprojection') do 
        ids = Movie.reprojection.pluck(:id).uniq
        Movie.where(id: ids)
      end
    end
  end
end
