class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @artworks = []
    20.times do
      @artworks << Artwork.all.sample
    end
    @artwork_count = Artwork.all.count
    @users = User.all
    @markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
      }
    end
  end
end
