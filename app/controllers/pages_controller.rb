class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @artworks = []
    12.times do
      @artworks << Artwork.all.sample
    end
  end
end
