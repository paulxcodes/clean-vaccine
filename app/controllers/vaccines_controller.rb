class VaccinesController < ApplicationController

  def index
    @vaccines = Vaccine.all
  end

  def show
    @vaccine = Vaccine.find(params[:id])
  end

  def new
    @vaccine = Vaccine.new
  end

  def create
    @vaccine = Vaccine.new

    if @vaccine.save
      redirect_to vaccine_path(@vaccine)
    else
      render :new
    end
  end

end
