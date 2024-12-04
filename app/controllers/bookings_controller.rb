class BookingsController < ApplicationController
  before_action :set_booking, only: [:new, :create]

  def set_booking
    @artwork = Artwork.find(params[:artwork_id])
    if current_user.nil?
      redirect_to new_user_session_path, alert: "Vous devez être connecté pour effectuer une réservation."
    else
      @booking = @artwork.bookings.new
    end
  end

  def new
  end

  def create
    if current_user.nil?
      redirect_to new_user_session_path, alert: "Vous devez être connecté pour effectuer une réservation."
      return
    end

    @booking = @artwork.bookings.new(booking_params)
    @booking.renter = current_user
    @booking.price = @booking.calculate_price

    if @booking.save
      redirect_to booking_path(@booking), notice: "Réservation effectuée"
    else
      flash.now[:alert] = "Erreur lors de la réservation"
      render "artworks/show", status: :unprocessable_entity
    end
  end

  def accept
    @booking = Booking.find(params[:id])
    @booking.validated = true
    if @booking.save
      redirect_to dashboard_path
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  # def accept
  #   @booking.update!(status: :accepted)
  #   redirect_to owner_bookings_path, notice: "Réservation acceptée"
  # end

  # def decline
  #   @booking.update!(status: :declined)
  #   redirect_to owner_bookings_path, notice: "Réservation refusée"
  # end

  private

  def booking_params
    params.require(:booking).permit(:begin_date, :end_date)
  end

end
