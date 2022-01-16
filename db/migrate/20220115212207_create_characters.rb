class CreateCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :characters do |t|
      t.string :hero, index: true
      t.string :legal_name, index: true
      t.string :description
      t.integer :universe_id
      t.string :universe

      t.timestamps
    end
  end
end
