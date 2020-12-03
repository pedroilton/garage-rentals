class GaragesController < ApplicationController
  def index
    @garages = Garage.all.select do |garage|
      garage.rentals.nil? || garage.rentals.select do |rental|
        rental.start_date <= Date.today && (rental.end_date.nil? || rental.end_date >= Date.today)
      end.empty?
    end
  end

  def show
    @garage = Garage.find(params[:id])
    @rentals = @garage.rentals
  end

  def new
    @garage = Garage.new
  end

  def create
    @garage = Garage.new(garage_params)
    @garage.user = current_user
    if @garage.save
      redirect_to @garage, notice: 'Garage was successfully created!'
    else
      render :new
    end
  end

  private

  def garage_params
    params.require(:garage).permit(:title, :address, :price, :description)
  end
end
