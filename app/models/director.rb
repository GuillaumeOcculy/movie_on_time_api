class Director < ApplicationRecord
  # Associations
  belongs_to :movie
  belongs_to :person

  # Validations
  validates_presence_of :external_id, :name
end
