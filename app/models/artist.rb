class Artist < ApplicationRecord
  validates :artist_display_name, presence: true
  has_many :artworks
end
