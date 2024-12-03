class Booking < ApplicationRecord
  belongs_to :renter, class_name: "User"
  belongs_to :artwork
  validates :begin_date , presence: true
  validates :end_date , presence: true
  validates_comparison_of :begin_date, less_than: :end_date, greater_than: -> { Date.today }

  def calculate_price
    (end_date - begin_date).to_i * artwork.price_by_day
  end
end
