class Artwork < ApplicationRecord
  belongs_to :artist
  belongs_to :owner, class_name: "User"
  has_many :bookings

  has_one_attached :photo

  validates :title, presence: true
  validates :price_by_day, presence: true, numericality: { only_numeric: true, greater_than: 50 }

  include PgSearch::Model

  pg_search_scope :search_by_title_and_artist_display_name,

  against: :title,
   associated_against: {
     artist: [ :artist_display_name ]
   },

  using: {
      tsearch: { prefix: true,
                },
      trigram: {}
     }

  def unavailable_dates
    bookings.pluck(:begin_date, :end_date)
  end

  def similar_artworks
    Artwork.where.not(id: id)
            .where(artist_id: artist_id)
            .limit(4)
  end
end
