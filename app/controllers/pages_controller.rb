class PagesController < ApplicationController
  def home
    @artworks = []
    10.times do
      @artworks << Artwork.all.sample
    end
  end
end
