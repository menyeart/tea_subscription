class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.decimal :price, precision: 8, scale: 2
      t.integer :status, default: 0
      t.integer :frequency

      t.timestamps
    end
  end
end
