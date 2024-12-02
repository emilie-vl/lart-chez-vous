class Artwork < ApplicationRecord
  belongs_to :artist
  belongs_to :owner, class_name: "User"
end
