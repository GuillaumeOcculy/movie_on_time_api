class CreateDirectors < ActiveRecord::Migration[5.2]
  def change
    create_table :directors do |t|
      t.belongs_to :movie, foreign_key: true
      t.belongs_to :person, foreign_key: true
      t.string :external_id
      t.string :name

      t.timestamps
    end
  end
end
