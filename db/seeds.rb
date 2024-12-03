# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

artist = Artist.create(artist_display_name: "Vincent Van Gogh", artist_nationality: "Dutch")
owner = User.create(email: "owner@example.com", password: "password", first_name: "Vincent", last_name: "Dupuis", address: "1000 Bruxelles")
Artwork.create(
  title: "La nuit étoilée",
  image_url: "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSrIPX_fC6ZPp9N1gFbNsQ-7co-olHwtiDYSoUAtvwK9TYHvpfO-078uebLb0vEJMYOKEgJG-Ee8-y804Ab53dYyPiRRaTcHJLzT6IKMA",
  price_by_day: 300.0,
  classification: "Peinture",
  object_date: "1889",
  dimensions: "73.7 cm × 92.1 cm",
  artist: artist,
  owner: owner
)
