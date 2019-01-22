class CreateCasts < ActiveRecord::Migration[5.2]
  def change
    create_table :casts do |t|
      t.belongs_to :movie, foreign_key: true
      t.belongs_to :person, foreign_key: true
      t.string :external_id
      t.string :name
      t.string :character

      t.timestamps
    end
  end
end
