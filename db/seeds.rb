# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create(first_name:"Bobby",last_name:"Bob", email:"bob@bobby.com", address:"chez Bobby")
User.create(first_name:"Robby",last_name:"Rob", email:"rob@robby.com", address:"chez Robby")
User.create(first_name:"Jobby",last_name:"Job", email:"job@jobby.com", address:"chez Jobby")

Artist.create(artist_display_name:"Blobby", artist_nationality:"Bloblandish")
Artist.create(artist_display_name:"Globby")

Artwork.create("piece of cake", "cake.jpg", )
Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
Movie.create(title: "The Green Mile", overview: "A supernatural tale set on death row in a Southern prison.", poster_url: "https://image.tmdb.org/t/p/original/velWPhVMQeQKcxggNEU8Ymlo52R.jpg", rating: 8.5)
Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)

List.create(name: "Drama")
List.create(name: "All time favourites")
List.create(name: "Girl Power")

Bookmark.create(comment: "Recommended by Johnny", movie_id: 3, list_id: 2)
Bookmark.create(comment: "SuperHero Movies", movie_id: 1, list_id: 3)
Bookmark.create(comment: "Spielbeauties", movie_id: 2, list_id: 2)
Bookmark.create(comment: "2020 release", movie_id: 5, list_id: 1)
Bookmark.create(comment: "Based on Stephen King's novel", movie_id: 4, list_id: 3)

Artist
