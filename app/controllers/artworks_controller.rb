class ArtworksController < ApplicationController
  def index
    @artworks = Artwork.where(title: "La nuit étoilée")         #where(title: params[:query])
  end
  def show
    @artwork = Artwork.find(params[:id])
    @booking = Booking.new
  end
end
