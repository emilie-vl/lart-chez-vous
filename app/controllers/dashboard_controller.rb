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

  def destroy_artwork
    @artwork = Artwork.find(params[:id])

    if @artwork.owner_id == current_user.id
      if @artwork.bookings.exists?
        redirect_to dashboard_path(@dashboard, anchor: "myArtworks"), alert: "Vous ne pouvez pas supprimer cette œuvre car elle est liée à des réservations.", status: :see_other
      else
        @artwork.destroy
        redirect_to dashboard_path(@dashboard, anchor: "myArtworks"), notice: "Votre œuvre a bien été supprimée.", status: :see_other
      end
    else
      redirect_to dashboard_path(@dashboard, anchor: "myArtworks"), alert: "Vous ne pouvez pas supprimer cette œuvre.", status: :see_other
    end
  end
end
