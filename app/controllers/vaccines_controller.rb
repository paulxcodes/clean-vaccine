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

  private

  def find_vaccine
    @vaccine = Vaccine.find(params[:id])
    authorize @vaccine
  end

  def vaccine_params
    params.require(:vaccine).permit(:name, :description)
  end

end
