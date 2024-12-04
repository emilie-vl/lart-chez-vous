class DashboardController < ApplicationController
  def index
  @user = current_user
  @artworks = Artwork.where("owner_id = ?", current_user.id)
  end
end
