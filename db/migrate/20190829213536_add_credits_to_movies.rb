class AddCreditsToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :during_credits, :string
    add_column :movies, :after_credits, :string
  end
end
