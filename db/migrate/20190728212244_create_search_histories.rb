class CreateSearchHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :search_histories do |t|
      t.belongs_to :user, foreign_key: true
      t.string :content
      t.string :controller
      t.string :action

      t.timestamps
    end
  end
end
