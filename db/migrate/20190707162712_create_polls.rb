class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.integer :creator_id
      t.text :body, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
