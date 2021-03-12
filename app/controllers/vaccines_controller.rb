class VaccinesController < ApplicationController

  before_action :find_vaccine, only: [:show, :edit, :update, :destroy]
  def index
    @vaccines = policy_scope(Vaccine)
  end

  def show
    @vaccine = Vaccine.find(params[:id])
    # @reservation = Reservation.find(params[@vaccine.id])
  end

  def new
    @vaccine = Vaccine.new
    authorize @vaccine
  end

  def create
    @vaccine = Vaccine.new(vaccine_params)
    @vaccine.user = current_user
    if @vaccine.save
      redirect_to vaccine_path(@vaccine)
    else
      render :new
    end
    authorize @vaccine
  end

  def edit
  end

  def update
    if @vaccine.update(vaccine_params)
      redirect_to vaccine_path(@vaccine), notice: "Vaccine was successfully updated"
    else
      render :edit
    end
    authorize @vaccine
  end

  def destroy
    @vaccine.destroy
    redirect_to vaccines_path, notice: "Vaccine was successfully deleted"
  end

  def dashboard
    # Vaccines you have listed
    # @vaccines = Vaccine.where(user: current_user)
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

  private

  def find_vaccine
    @vaccine = Vaccine.find(params[:id])
    authorize @vaccine
  end

  def vaccine_params
    params.require(:vaccine).permit(:name, :description, :photo)
  end

end
