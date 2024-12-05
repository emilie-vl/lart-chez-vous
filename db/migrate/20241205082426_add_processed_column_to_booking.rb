class AddProcessedColumnToBooking < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :processed, :boolean, default: false
  end
end
