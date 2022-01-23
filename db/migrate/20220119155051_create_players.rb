class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.references :character, null: false, foreign_key: true
      t.references :combat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
