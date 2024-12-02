class Artist < ApplicationRecord
  validates :artist_display_name, presence: true
end
