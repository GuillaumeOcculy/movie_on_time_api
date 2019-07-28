class SearchHistory < ApplicationRecord
  # Associations
  belongs_to :user, optional: true

  # Validations
  validates_presence_of :content, :controller, :action
end
