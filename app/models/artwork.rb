class Artwork < ApplicationRecord
  belongs_to :artist
  belongs_to :owner, class_name: "User"
  has_many :bookings
<<<<<<< HEAD
=======
  has_one_attached :photo
>>>>>>> master

  validates :title, presence: true
  validates :price_by_day, presence: true, numericality: { only_numeric: true, greater_than: 50 }
<<<<<<< HEAD
  validates :classification, presence: true

  def unavailable_dates
    bookings.pluck(:begin_date, :end_date)
=======

  def similar_artworks
    Artwork.where.not(id: id)
            .where(artist_id: artist_id)
            .limit(4)
>>>>>>> master
  end
end
