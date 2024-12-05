class AddValidationColumnToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :validated, :boolean, default: false
  end
end
