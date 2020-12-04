class RentalsController < ApplicationController
  # rentals_path
  def index
    @rentals = Rental.all
    # @user = current_user # devise está funcionando?
    @user = User.all
  end

  # new_garage_rental_path
  def new
    @rental = Rental.new
    @garage = Garage.find(params[:garage_id])
  end

  # garage_rentals_path
  def create
    # @user = current_user
    @rental = Rental.new(rentals_params)
    @rental.user = User.first
    @rental.garage = Garage.find(params[:garage_id])

    if @rental.save
      redirect_to rentals_path # alterar para o show do Garage
      # redirect_to @rental.garage
    else
      render :new
    end
  end

  def edit
    @rental = Rental.find(params[:id])
  end

  def update
    @rental = Rental.find(params[:id])
    if @rental.update(rentals_params)
      redirect_to rentals_path, notice: 'Rental was successfully updated.'
      # redirect_to @rental.garage
    else
      render :edit
    end
  end

  private

  def rentals_params
    params.require(:rental).permit(:start_date, :end_date)
  end
end
