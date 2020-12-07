class RentalsController < ApplicationController
  before_action :set_rental, only: %i[edit update]
  after_action :authorize_rental, except: :index

  # rentals_path
  def index
    @rentals = policy_scope(Rental)
  end

  def show
    redirect_to rentals_path
  end

  # new_garage_rental_path
  def new
    @rental = Rental.new
    @garage = Garage.find(params[:garage_id])
  end

  # garage_rentals_path
  def create
    @rental = Rental.new(rentals_params)
    @rental.user = current_user
    @rental.garage = Garage.find(params[:garage_id])

    if @rental.save
      redirect_to rentals_path # alterar para o show do Garage
      # redirect_to @rental.garage
    else
      redirect_to @rental.garage
    end
  end

  def edit
    # @rental = Rental.find(params[:id])
  end

  def update
    # @rental = Rental.find(params[:id])
    if @rental.update(rentals_params)
      redirect_to rentals_path, notice: 'Rental successfully ended.'
      # redirect_to @rental.garage
    else
      redirect_to @rental.garage
    end
  end

  private

  def set_rental
    @rental = Rental.find(params[:id])
  end

  def rentals_params
    params.require(:rental).permit(:start_date, :end_date)
  end

  def authorize_rental
    authorize @rental
  end
end
