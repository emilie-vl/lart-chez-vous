class Booking < ApplicationRecord
  belongs_to :renter, class_name: "User"
  belongs_to :artwork

  validates :begin_date , presence: true
  validates :end_date , presence: true
  validates_comparison_of :begin_date, less_than: :end_date, greater_than: -> { Date.today }

  validate :no_overlapping_bookings

  def calculate_price
    (end_date - begin_date).to_i * artwork.price_by_day
  end

  private

  def no_overlapping_bookings
    overlapping_bookings = artwork.bookings.where.not(id: id).where(
      "(begin_date, end_date) OVERLAPS (?, ?)",
      begin_date, end_date
    )
    if overlapping_bookings.exists?
      errors.add(:begin_date, "L'oeuvre est déjà réservée à ces dates.")
    end
  end
end
