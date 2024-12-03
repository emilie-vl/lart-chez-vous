require 'open-uri'
require 'json'

BASE_USERS = [
  { first_name: "Guillaume", last_name: "Fournier", email: "gf@lartchezvous.com", address: "Misérieux", password: "kingkong"},
  { first_name: "Hélène", last_name: "Demanet", email: "hd@lartchezvous.com", address: "Bruxelles", password: "kingkong"},
  { first_name: "Emilie", last_name: "Vennat-Louveau", email: "evl@lartchezvous.com", address: "Bessines-sur-Gartempes", password: "kingkong"},
  { first_name: "Cédric", last_name: "Lang-Roth", email: "clr@lartchezvous.com", address: "Betteville", password: "kingkong"},
]

puts "---Destroying all data"
Booking.destroy_all
Artwork.destroy_all
Artist.destroy_all
User.destroy_all
puts "---All data destroyed"

puts "---Creating base users"
BASE_USERS.each { |user| User.create(user) }
puts "---Base users created"

puts "---Fetching artists"
artists_url = "http://www.wikiart.org/en/Popular-Artists/alltime/1?json=2&PageSize=1"
artists = JSON.parse(URI.parse(artists_url).read)

puts "---Fetching artworks"
artists.first(10).each do |artist|
  artist_object = Artist.create(
    artist_display_name: artist['artistName']
  )
  artworks = JSON.parse(URI.parse("http://www.wikiart.org/en/App/Painting/PaintingsByArtist?artistUrl=#{artist['url']}&json=2").read)
  artworks.each do |artwork|
  Artwork.create(
    { artist: artist_object,
    title: artwork['title'],
    image_url: artwork['image'],
    price_by_day: rand(50..27000),
    object_date: artwork['completitionYear'],
    dimensions: "#{artwork['width']} x #{artwork['height']}",
    owner: User.all.sample
    }
  )
  end
end
puts "---Artists and artworks created"
puts "---Creating Magritte"
magritte = Artist.create(artist_display_name: "René Magritte")
artworks = JSON.parse(URI.parse("http://www.wikiart.org/en/App/Painting/PaintingsByArtist?artistUrl=rene-magritte&json=2").read)
artworks.each do |artwork|
  Artwork.create(
    { artist: magritte,
    title: artwork['title'],
    image_url: artwork['image'],
    price_by_day: rand(50..27000),
    object_date: artwork['completitionYear'],
    dimensions: "#{artwork['width']} x #{artwork['height']}",
    owner: User.all.sample
    }
  )
end
puts "---Magritte created"

puts "---Creating bookings"
User.all.each do |user|
  10.times do
    artwork = Artwork.all.sample
    booking = Booking.new({
      begin_date: Date.today - rand(365),
      renter: user,
      artwork: artwork
    })
    booking.end_date = booking.begin_date + rand(10)
    booking.price = artwork.price_by_day * (booking.end_date - booking.begin_date)
    booking.save(validate: false)
  end
end
puts "---Bookings created"