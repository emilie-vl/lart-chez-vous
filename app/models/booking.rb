class Booking < ApplicationRecord
  belongs_to :renter, class_name: "User"
  belongs_to :artwork

  validates :begin_date , presence: true
  validates :end_date , presence: true
  validates_comparison_of :begin_date, less_than: :end_date, greater_than: -> { Date.today }

  validate :no_overlapping_bookings
  validate :validate_date_order

  def calculate_price
    if begin_date.nil? || end_date.nil?
      return 0
    else
      (end_date - begin_date).to_i * artwork.price_by_day
    end
  end

  private

  def no_overlapping_bookings
    overlapping_bookings = artwork.bookings.where.not(id: id).where(
      "(begin_date, end_date) OVERLAPS (?, ?)",
      begin_date, end_date
    )
    if overlapping_bookings.exists?
      errors.add(:base, "L'oeuvre est déjà réservée à ces dates.")
    end
  end

  def validate_date_order
    return if begin_date.blank? || end_date.blank?

    if begin_date >= end_date
      errors.add(:begin_date, "doit être avant la date de fin.")
    elsif begin_date <= Date.today
      errors.add(:begin_date, "doit être après aujourd'hui.")
    end
  end
end
