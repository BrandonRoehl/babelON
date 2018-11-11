class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.references :conversation, foreign_key: true
      t.datetime :time_sent
      t.datetime :time_read
      t.integer :base_id, null: false

      t.timestamps
    end
  end
end
