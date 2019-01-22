class City < ApplicationRecord
  # Associations
  belongs_to :country

  # Validations
  validates_presence_of :name, :external_id, :country_code
end
