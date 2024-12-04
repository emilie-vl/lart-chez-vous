class PagesController < ApplicationController
  def home
    @artworks = []
    12.times do
      @artworks << Artwork.all.sample
    end
  end
end
