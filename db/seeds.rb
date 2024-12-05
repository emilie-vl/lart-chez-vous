require 'open-uri'
require 'json'
require 'faker'
require 'uri'
require 'net/http'

BASE_USERS = [
  { first_name: "Guillaume", last_name: "Fournier", email: "gf@lartchezvous.com", address: "Misérieux", password: "kingkong"},
  { first_name: "Hélène", last_name: "Demanet", email: "hd@lartchezvous.com", address: "Bruxelles", password: "kingkong"},
  { first_name: "Emilie", last_name: "Vennat-Louveau", email: "evl@lartchezvous.com", address: "Bessines-sur-Gartempes", password: "kingkong"},
  { first_name: "Cédric", last_name: "Lang-Roth", email: "clr@lartchezvous.com", address: "Betteville", password: "kingkong"},
]

CITIES = [
  "Paris", "Marseille", "Lyon", "Toulouse", "Nice", "Nantes", "Strasbourg", "Montpellier", "Bordeaux", "Lille",
  "Rennes", "Reims", "Le Havre", "Saint-Étienne", "Toulon", "Grenoble", "Dijon", "Angers", "Nîmes", "Villeurbanne",
  "Le Mans", "Aix-en-Provence", "Clermont-Ferrand", "Brest", "Tours", "Amiens", "Limoges", "Annecy", "Perpignan", "Boulogne-Billancourt",
  "Metz", "Besançon", "Orléans", "Saint-Denis", "Rouen", "Argenteuil", "Montreuil", "Mulhouse", "Caen", "Nancy",
  "Saint-Paul", "Roubaix", "Tourcoing", "Nanterre", "Avignon", "Vitry-sur-Seine", "Créteil", "Dunkerque", "Poitiers", "Asnières-sur-Seine",
  "Versailles", "Colmar", "Courbevoie", "Fort-de-France", "Évry", "Cergy", "Bayonne", "Chambéry", "La Rochelle", "Calais",
  "Troyes", "Valenciennes", "Saint-Pierre", "Bourges", "Cherbourg", "Antibes", "Rueil-Malmaison", "Béziers", "La Roche-sur-Yon", "Saint-Malo",
  "Cannes", "Quimper", "Lorient", "Villeneuve-d'Ascq", "Hyères", "Vannes", "Fréjus", "Arles", "Clamart", "Beauvais",
  "Niort", "Levallois-Perret", "Antony", "Cayenne", "Ajaccio", "Carcassonne", "Valence", "Saint-Quentin", "Pessac", "Montauban",
  "Ivry-sur-Seine", "Clichy", "Pau", "La Seyne-sur-Mer", "Neuilly-sur-Seine", "Sarcelles", "Charleville-Mézières", "Vénissieux", "Saint-Brieuc", "Pontault-Combault",
  "Laval", "Châteauroux", "Sète", "Cholet", "Chalon-sur-Saône", "Meaux", "Saint-Nazaire", "Blois", "Mérignac", "Compiègne",
  "Belfort", "Vincennes", "Auxerre", "Saint-Ouen", "Épinay-sur-Seine", "Saint-Maur-des-Fossés", "Alès", "Châtillon", "Brive-la-Gaillarde", "Gap",
  "Draguignan", "Chartres", "Angoulême", "Bourg-en-Bresse", "Corbeil-Essonnes", "Poissy", "Saint-Germain-en-Laye", "Montélimar", "Salon-de-Provence", "Mont-de-Marsan",
  "Mantes-la-Jolie", "Romans-sur-Isère", "Cambrai", "Vichy", "Périgueux", "Saintes", "Châlons-en-Champagne", "Alençon", "Cognac", "Montluçon",
  "Bergerac", "Moulins", "Rochefort", "Saint-Raphaël", "Dax", "Martigues", "Pontoise", "Biarritz", "Châtellerault", "Roanne",
  "Nevers", "Abbeville", "Orange", "Carpentras", "Bastia", "Aubagne", "Grasse", "Saint-Dizier", "Sarreguemines", "Armentières",
  "Dreux", "Vierzon", "Lunel", "Concarneau", "Millau", "Senlis", "Guéret", "Menton", "Dieppe", "Lens",
  "Saint-Omer", "Chaumont", "Castres", "Verdun", "Saumur", "Apt", "Rodez", "Fontainebleau", "Bayeux", "Granville",
  "Bruxelles", "Anvers", "Gand", "Charleroi", "Liège", "Bruges", "Namur", "Louvain", "Mons", "Wavre",
  "Ostende", "Courtrai", "Tournai", "Hasselt", "Malines", "Verviers", "Seraing", "La Louvière", "Mouscron", "Genk"
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

puts "---Creating random users"
500.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "kingkong", address: CITIES.sample)
end
puts "---Created random users"

puts "---Fetching artists"
artists_url = "http://www.wikiart.org/en/Popular-Artists/alltime/1?json=2&PageSize=1"
artists = JSON.parse(URI.parse(artists_url).read)

puts "---Fetching artworks"
artists.first(20).each do |artist|
  artist_object = Artist.create(
    artist_display_name: artist['artistName']
  )
  artworks = JSON.parse(URI.parse("http://www.wikiart.org/en/App/Painting/PaintingsByArtist?artistUrl=#{artist['url']}&json=2").read)
  artworks.each do |artwork|
    begin
      uri = URI(artwork['image'])
      img_url = Net::HTTP.get_response(uri)
      image = URI.parse(artwork['image']).open
      # Check if image exists
      if img_url.code == "200"
        artwork = Artwork.new(
          artist: artist_object,
          title: artwork['title'],
          price_by_day: rand(50..27000),
          object_date: artwork['completitionYear'],
          dimensions: "#{artwork['width']} x #{artwork['height']}",
          owner: User.all.sample
        )
        artwork.photo.attach(io: image, filename: "#{artwork['title']}.jpg", content_type: "image/jpg")
        artwork.save!
      else
        puts "Image not found for artwork #{artwork['title']}"
      end
    rescue => e
      puts "Error processing artwork #{artwork['title']}: #{e.message}"
    end
  end
end
puts "---Artists and artworks created"

puts "---Creating Magritte"
magritte = Artist.create(artist_display_name: "René Magritte")
artworks = JSON.parse(URI.parse("http://www.wikiart.org/en/App/Painting/PaintingsByArtist?artistUrl=rene-magritte&json=2").read)
artworks.each do |artwork|
  begin
    uri = URI(artwork['image'])
    img_url = Net::HTTP.get_response(uri)
    image = URI.parse(artwork['image']).open
    # Check if image exists
    if img_url.code == "200"
      artwork = Artwork.new(
        artist: magritte,
        title: artwork['title'],
        price_by_day: rand(50..27000),
        object_date: artwork['completitionYear'],
        dimensions: "#{artwork['width']} x #{artwork['height']}",
        owner: User.all.sample
      )
      artwork.photo.attach(io: image, filename: "#{artwork['title']}.jpg", content_type: "image/jpg")
      artwork.save!
    else
      puts "Image not found for artwork #{artwork['title']}"
    end
  rescue => e
    puts "Error processing artwork #{artwork['title']}: #{e.message}"
  end
end
puts "---Magritte created"

puts "---Creating bookings"
User.all.each do |user|
  3.times do
    artwork = Artwork.all.sample
    booking = Booking.new({
      begin_date: Date.today - rand(365),
      renter: user,
      artwork: artwork,
      processed: true
    })
    booking.end_date = booking.begin_date + rand(1..10)
    booking.price = artwork.price_by_day * (booking.end_date - booking.begin_date)
    booking.save(validate: false)
  end
end
puts "---Bookings created"
