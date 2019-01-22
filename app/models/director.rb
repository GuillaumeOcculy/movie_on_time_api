class Director < ApplicationRecord
  # Associations
  belongs_to :movie
  belongs_to :person

  validates_presence_of :external_id, :name
end
