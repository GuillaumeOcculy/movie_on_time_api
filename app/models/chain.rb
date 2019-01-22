class Chain < ApplicationRecord
  # Associations
  has_many :chain_countries
  has_many :countries, through: :chain_countries
  has_many :cinemas, dependent: :destroy
  
  # Validations
  validates_presence_of :external_id, :name
end
