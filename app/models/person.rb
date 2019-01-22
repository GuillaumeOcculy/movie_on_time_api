class Person < ApplicationRecord
  # Associations
  has_many :casts
  has_many :directors

  # Validations
  validates_presence_of :external_id, :name
end
