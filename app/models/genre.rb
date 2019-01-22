class Genre < ApplicationRecord
  # Validations
  validates_presence_of :external_id, :name
end
