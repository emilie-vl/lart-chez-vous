class BookingsController < ApplicationController
  before_action :set_booking, only: [:new, :create]
  before_action :authorize_owner, only: [:accept, :decline]

  def new
    @booking = @artwork.bookings.new
  end

  def create
    @booking = @artwork.bookings.new(booking_params)
    @booking.renter = current_user

    @booking.price = @booking.calculate_price

    if @booking.save
      redirect_to booking_path(@booking), notice: "Réservation effectuée"
    else
      render :new, alert: "Erreur lors de la réservation", status: :unprocessable_entity
    end
  end

  def accept
    @booking.update!(status: :accepted)
    redirect_to owner_bookings_path, notice: "Réservation acceptée"
  end

  def decline
    @booking.update!(status: :declined)
    redirect_to owner_bookings_path, notice: "Réservation refusée"
  end

  private

  def set_booking
    @artwork = Artwork.find(params[:artwork_id])
  end

  def booking_params
    params.require(:booking).permit(:begin_date, :end_date)
  end

  def authorize_owner
    @booking = Booking.find(params[:id])
    unless @booking.artwork.owner == current_user
      redirect_to root_path, alert: "Connectez-vous pour effectuer cette action"
    end
  end
end
