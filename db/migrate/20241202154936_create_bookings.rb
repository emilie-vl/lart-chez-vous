class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.date :begin_date
      t.date :end_date
      t.integer :price
      t.references :renter, null: false, foreign_key: { to_table: :users }
      t.references :artwork, null: false, foreign_key: true

      t.timestamps
    end
  end
end
