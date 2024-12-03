class ArtworksController < ApplicationController
  def index
    @artworks = Artwork.where(title: params[:query])
  end
end
