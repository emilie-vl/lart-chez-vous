class Artwork < ApplicationRecord
  belongs_to :artist
  belongs_to :owner, class_name: "User"
  has_many :bookings
  has_one_attached :photo

  validates :title, presence: true
  validates :price_by_day, presence: true, numericality: { only_numeric: true, greater_than: 50 }
end
