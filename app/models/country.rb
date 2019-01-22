class Country < ApplicationRecord
  # Associations
  has_many :cities, dependent: :destroy
  
  #Validations
  validates_presence_of :name, :iso_code, :language
end
