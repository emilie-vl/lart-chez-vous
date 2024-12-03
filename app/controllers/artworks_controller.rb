class ArtworksController < ApplicationController
  def show
    @artwork = Artwork.find(params[:id])
    @booking = Booking.new
  end

  def new
    @artwork = Artwork.new
  end

  def create
    @artwork = Artwork.new(artwork_params)
    @artwork.owner = current_user
    @artwork.price_by_day = params[:artwork][:price_by_day].to_i
    if @artwork.save
      redirect_to artwork_path(@artwork)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def artwork_params
    params.require(:artwork).permit(:title, :object_date, :dimensions, :artist_id, :photo, :price_by_day)
  end
end
