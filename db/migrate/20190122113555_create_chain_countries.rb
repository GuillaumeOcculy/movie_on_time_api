class CreateChainCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :chain_countries do |t|
      t.belongs_to :chain, foreign_key: true
      t.belongs_to :country, foreign_key: true

      t.timestamps
    end
  end
end
