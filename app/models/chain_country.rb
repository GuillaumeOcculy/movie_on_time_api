class ChainCountry < ApplicationRecord
  # Associations
  belongs_to :chain
  belongs_to :country
end
