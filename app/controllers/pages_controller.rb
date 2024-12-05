class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @artworks = Artwork.order("RANDOM()").limit(20)
    @artwork_count = Artwork.count
    @users = User.select(:id, :latitude, :longitude)
             .includes(owned_artworks: { photo_attachment: :blob })
             .geocoded

    @markers = Rails.cache.fetch("user_markers", expires_in: 1.hour) do
      @users.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        info_window_html: render_to_string(partial: "users/info_window", locals: {user: user})
      }
      end
    end
  end
end
