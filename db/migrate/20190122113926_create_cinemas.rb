class CreateCinemas < ActiveRecord::Migration[5.2]
  def change
    create_table :cinemas do |t|
      t.belongs_to :chain, foreign_key: true
      t.belongs_to :country, foreign_key: true
      t.string :external_id
      t.string :name
      t.string :phone
      t.string :street
      t.string :house
      t.string :post_code
      t.string :city
      t.string :state
      t.string :state_abbr
      t.string :country_code
      t.float :latitude
      t.float :longitude
      t.string :booking_type
      t.string :website
      t.string :image_url

      t.timestamps
    end
    add_index :cinemas, :country_code
    add_index :cinemas, [:latitude, :longitude]
  end
end
