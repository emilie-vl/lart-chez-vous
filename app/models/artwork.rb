class Artwork < ApplicationRecord
  belongs_to :artist
  belongs_to :owner, class_name: "User"
  has_many :bookings

  validates :title, presence: true
  validates :image_url, presence: true
  validates :price_by_day, presence: true, numericality: { only_numeric: true, greater_than: 50 }

  def similar_artworks
    Artwork.where.not(id: id)
            .where(artist_id: artist_id)
            .limit(4)
  end
end
