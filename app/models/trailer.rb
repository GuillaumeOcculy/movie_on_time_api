class Trailer < ApplicationRecord
  # Associations
  belongs_to :movie

  # Validations
  validates_presence_of :language, :format, :url

  # Scopes
  scope :by_language, -> (iso_code) { where(language: iso_code.downcase) }
end
