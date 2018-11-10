class CreateLocalizations < ActiveRecord::Migration[5.2]
  def change
    create_table :localizations do |t|
      t.references :message, foreign_key: true
      t.text :content
      t.string :lang

      t.timestamps
    end
  end
end
