class CreateTrailers < ActiveRecord::Migration[5.2]
  def change
    create_table :trailers do |t|
      t.belongs_to :movie, foreign_key: true
      t.string :language
      t.string :format
      t.string :transfert
      t.string :url

      t.timestamps
    end
  end
end
