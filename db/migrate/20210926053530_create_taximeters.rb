class CreateTaximeters < ActiveRecord::Migration[6.1]
  def change
    create_table :taximeters do |t|
      t.decimal :start_price, precision: 6, scale: 2
      t.decimal :km_price, precision: 6, scale: 2
      t.decimal :minute_price, precision: 6, scale: 2
      t.decimal :minimum_price, precision: 6, scale: 2
      t.time :time_from
      t.time :time_to
      t.string :days
      t.references :company, null: false, foreign_key: true
      t.integer :time_from_minutes
      t.integer :time_to_minutes

      t.timestamps
    end
  end
end
