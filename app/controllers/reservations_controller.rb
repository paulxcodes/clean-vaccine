class ReservationsController < ApplicationController

  def new
    @vaccine = Vaccine.find(params[:vaccine_id])
    @user = current_user
    @reservation = Reservation.new
    authorize @reservation
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @vaccine = Vaccine.find(params[:vaccine_id])
    @reservation.status = 'Pending'
    @user = current_user
    @reservation.vaccine = @vaccine
    @reservation.user = @user
    @reservation.save

    # Temporary redirect until the history page is created
    redirect_to vaccine_path(@vaccine)
    authorize @reservation
  end

  private

  def reservation_params
    params.require(:reservation).permit(:date)
  end
end
