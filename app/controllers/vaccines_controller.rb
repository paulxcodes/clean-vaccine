class VaccinesController < ApplicationController

  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @vaccines = policy_scope(Vaccine.search_by_name_and_description(params[:query]))
     else
      @vaccines = policy_scope(Vaccine)
     end
  end

  def show
    @vaccine = Vaccine.find(params[:id])
    authorize @vaccine
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
  end

  private

  def find_vaccine
    @vaccine = Vaccine.find(params[:id])
    authorize @vaccine
  end

  def vaccine_params
    params.require(:vaccine).permit(:name, :description, :photo, :query)
  end

  def require_login
    unless current_user
      redirect_to new_user_session_path
    end
  end

end
