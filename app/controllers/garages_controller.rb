class GaragesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_garage, only: %i[show edit update destroy]

  def index
    @garages = policy_scope(Garage).select do |garage|
      garage.rentals.select do |rental|
        rental.start_date <= Date.today && (rental.end_date.nil? || rental.end_date >= Date.today)
      end.empty?
    end
  end

  def show
    if @garage.rentals.reject { |rental| rental.review.nil? }.any?
      @garage_rating = (@garage.rentals.inject(0.0) do |sum, rental|
        sum + rental.review.rating unless rental.review.nil?
      end / @garage.rentals.reject { |rental| rental.review.nil? }.count).round
    else
      @garage_rating = nil
    end
    authorize @garage
  end

  def new
    @garage = Garage.new
    authorize @garage
  end

  def create
    @garage = Garage.new(garage_params)
    @garage.user = current_user
    if @garage.save
      redirect_to @garage, notice: 'Garage was successfully created!'
    else
      render :new
    end
    authorize @garage
  end

  def edit
    authorize @garage
  end

  def update
    if @garage.update(garage_params)
      redirect_to @garage, notice: 'Garage was successfully updated.'
    else
      render :edit
    end
    authorize @garage
  end

  def destroy
    @garage.destroy
    redirect_to user_garages_path, notice: 'Garage was successfully destroyed.'
    authorize @garage
  end

  def list
    @garages = Garage.select { |garage| garage.user = current_user }
    # authorize @garage
  end

  private

  def set_garage
    @garage = Garage.find(params[:id])
  end

  def garage_params
    params.require(:garage).permit(:title, :address, :price, :description, photos: [])
  end
end
