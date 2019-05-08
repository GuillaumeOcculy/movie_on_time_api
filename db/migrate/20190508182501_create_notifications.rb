class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id, foreign_key: true
      t.belongs_to :actorable, polymorphic: true, index: true
      t.belongs_to :notifiable, polymorphic: true, index: true
      t.datetime :read_at
      t.string :action

      t.timestamps
    end
  end
end
