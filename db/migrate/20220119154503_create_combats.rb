class CreateCombats < ActiveRecord::Migration[6.1]
  def change
    create_table :combats do |t|
      t.integer :seed_number

      t.timestamps
    end
  end
end
