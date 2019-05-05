class CreateFavoriteCinemas < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_cinemas do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :cinema, foreign_key: true

      t.timestamps
    end
  end
end
