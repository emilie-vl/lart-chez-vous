class ArtworksController < ApplicationController
  def index
    @artworks = Artwork.all
    if params[:search].present?
      @artworks = @artworks.where(title: params[:search])
    end

  end
  def show
    @artwork = Artwork.find(params[:id])
    @booking = Booking.new
  end
end
