class BookingsController < ApplicationController
  before_action :set_booking, only: [:new, :create]

  def new
    @booking = @artwork.bookings.new
  end

  def create
    @booking = @artwork.bookings.new(booking_params)
    @booking.renter = current_user

    @booking.price = @booking.calculate_price

    if @booking.save
      redirect_to @artwork, notice: "Réservation effectuée"
    else
      render :new, alert: "Erreur lors de la réservation", status: :unprocessable_entity
    end
  end

  private

  def set_booking
    @artwork = Artwork.find(params[:artwork_id])
  end

  def booking_params
    params.require(:booking).permit(:begin_date, :end_date)
  end
end
