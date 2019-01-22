class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.belongs_to :country, foreign_key: true
      t.string :external_id
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :country_code

      t.timestamps
    end
  end
end
