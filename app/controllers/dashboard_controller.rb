class DashboardController < ApplicationController
  def index
  @user = current_user
  @artworks = Artwork.where("owner_id = ?", current_user.id)
  @past_rentals = Booking.where("renter_id = ? and end_date < ?", current_user.id, Date.today)
  @coming_rentals = Booking.where("renter_id = ? and begin_date >= ?", current_user.id, Date.today)
  @bookings = Booking.joins(:artwork).where(artworks: { owner_id: current_user.id })
  end
end
