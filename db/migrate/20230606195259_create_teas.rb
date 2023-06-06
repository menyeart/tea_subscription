class CreateTeas < ActiveRecord::Migration[7.0]
  def change
    create_table :teas do |t|
      t.string :title
      t.string :description
      t.decimal :brew_time, precision: 4, scale: 2
      t.integer :temp

      t.timestamps
    end
  end
end
