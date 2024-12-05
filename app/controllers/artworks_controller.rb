class ArtworksController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def index
    @artworks = Artwork.all
    if params[:search].present?
      @artworks = Artwork.search_by_title_and_artist_display_name(params[:search])
    end

  end
  def show
    store_location_for(:user, request.fullpath)
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

  def super_admin_index
    @artworks = Artwork.all
  end

  def destroy
    @artwork = Artwork.find(params[:id])
    @artwork.destroy
    redirect_to super_admin_artworks_path, status: :see_other
  end

  private

  def artwork_params
    params.require(:artwork).permit(:title, :object_date, :dimensions, :artist_id, :photo, :price_by_day)
  end
end
