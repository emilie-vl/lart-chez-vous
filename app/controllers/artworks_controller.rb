class ArtworksController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def index
    @users = User.near("#{current_user.address}", 100)
    @artwork_count = 0
    @users.each do |user|
      @artwork_count += user.owned_artworks.count
    end
    
    @markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        user_id: user.id
      }
    end
  
    @artworks = if params[:search].present?
      Artwork.search_by_title_and_artist_display_name(params[:search])
    else
      Artwork.all
    end
  
    @artworks = @artworks.page(params[:page])
  
    respond_to do |format|
      format.html
      format.json { 
  render json: @artworks.map { |artwork| 
    { 
      title: artwork.title,
      photo_url: helpers.cl_image_path(artwork.photo.key, height: 200, width: 200, crop: :fill),
      artist_name: artwork.artist.artist_display_name,
      dimensions: artwork.dimensions,
      price: artwork.price_by_day,
      path: artwork_path(artwork),
      can_delete: current_user&.id == artwork.owner_id,
      delete_path: destroy_artwork_path(artwork)
    }
  }
}
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

  private

  def artwork_params
    params.require(:artwork).permit(:title, :object_date, :dimensions, :artist_id, :photo, :price_by_day)
  end
end
