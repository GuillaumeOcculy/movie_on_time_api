class Rating < ApplicationRecord
  # Associations
  belongs_to :movie

  # Validations
  validates_uniqueness_of :name, scope: :movie_id
end
