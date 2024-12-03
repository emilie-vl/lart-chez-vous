class Artist < ApplicationRecord
  validates :artist_display_name, presence: true
  has_many :artworks, foreign_key: "artist_id"
end
