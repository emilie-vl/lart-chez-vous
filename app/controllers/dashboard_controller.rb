class DashboardController < ApplicationController
  def index
  @user = current_user
  @artworks = Artwork.where("owner_id = ?", current_user.id)
  @past_rentals = Booking.where("renter_id = ? and end_date < ?", current_user.id, Date.today)
  @coming_rentals = Booking.where("renter_id = ? and begin_date >= ?", current_user.id, Date.today)
  @bookings_to_validate = Booking.joins(:artwork).where(artworks: { owner_id: current_user.id }, validated: false).where("begin_date > ? AND processed = ?", Date.today, false)
  @bookings_validated = Booking.joins(:artwork).where(artworks: { owner_id: current_user.id }).where("validated = ? AND processed = ?", true, true)
  @bookings_declined = Booking.joins(:artwork).where(artworks: { owner_id: current_user.id }).where("validated = ? AND processed = ?", false, true)
  end
end
