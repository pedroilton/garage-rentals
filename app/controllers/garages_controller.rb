class GaragesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_garage, only: %i[show edit update destroy]

  def index
    @garages = Garage.select do |garage|
      garage.rentals.select do |rental|
        rental.start_date <= Date.today && (rental.end_date.nil? || rental.end_date >= Date.today)
      end.empty?
    end
  end

  def show
    if @garage.rentals.reject { |rental| rental.review.nil? }.any?
      @garage_rating = Math.round(@garage.rentals.inject(0.0) do |sum, rental|
        sum + rental.review.rating unless rental.review.nil?
      end / @garage.rentals.reject { |rental| rental.review.nil? }.count)
    else
      @garage_rating = nil
    end
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

  def edit
  end

  def update
    if @garage.update(garage_params)
      redirect_to @garage, notice: 'Garage was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @garage.destroy
    redirect_to user_garages_path, notice: 'Garage was successfully destroyed.'
  end

  def list
    @garages = Garage.select { |garage| garage.user = current_user }
  end

  private

  def set_garage
    @garage = Garage.find(params[:id])
  end

  def garage_params
    params.require(:garage).permit(:title, :address, :price, :description)
  end
end
