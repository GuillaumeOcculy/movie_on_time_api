class Chain < ApplicationRecord
  # Associations
  has_many :chain_countries
  has_many :countries, through: :chain_countries
  
  # Validations
  validates_presence_of :external_id, :name
end
