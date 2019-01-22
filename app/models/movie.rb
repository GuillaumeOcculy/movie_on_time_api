class Movie < ApplicationRecord
  # Validations
  validates :external_id, presence: true, uniqueness: true
end
