class DashboardController < ApplicationController
  def dashboard
    # Vaccines you have listed
    @vaccines = policy_scope(Vaccine).where(user: current_user)

    # Vaccines you have reserved(booked)
    @reservations = policy_scope(Reservation).where(user: current_user)

    # Reservations for your vaccines
    # Find all reservations where the owner of the vaccine is the current_user
    @reservations_for_seller = []
    @vaccines.each do |vaccine|
      vaccine.reservations.each do |reservation|
        @reservations_for_seller << reservation
      end
    end
  end

  def confirm
    @reservation = Reservation.find(params[:id])
    @reservation.status = 'Confirmed'
    @reservation.save
    redirect_to dashboard_path
    authorize @reservation
  end

  def cancel
    @reservation = Reservation.find(params[:id])
    @reservation.status = 'Cancelled'
    @reservation.save
    redirect_to dashboard_path
    authorize @reservation
  end
end
