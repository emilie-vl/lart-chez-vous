class PagesController < ApplicationController
  def home
    @artworks = [
      OpenStruct.new(
        title: "Le fils de l’homme",
        classification: "Peinture",
        image_url: "https://d1ee3oaj5b5ueh.cloudfront.net/thumbs/771xAUTO_original_article_2023_08_f14f4126-b3a9-4c03-94f3-024658ea6376.jpeg",
        dimensions: "116 x 89 cm",
        artist_display_name: "Magritte",
        price_by_day: 1500
      )
    ] * 12
  end
end
