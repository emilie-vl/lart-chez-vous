class ArtworksController < ApplicationController
  def show
    @artwork = Artwork.find(params[:id])
    @booking = Booking.new
  end

  def new
    @artwork = Artwork.new
  end

  private

  def artwork_params
    params.require(:artwork).permit(:title, :price_by_day, :object_date, :dimensions, :artist_id)
  end
end
