class Cinema < ApplicationRecord
  # Associations
  belongs_to :chain, required: false
  belongs_to :country
end
