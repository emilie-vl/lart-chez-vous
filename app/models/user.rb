class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :owned_bookings, class_name: "bookings", foreign_key: "renter_id"
  has_many :owned_artworks, class_name: "Artwork", foreign_key: "owner_id"
end
