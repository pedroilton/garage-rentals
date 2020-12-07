class ReviewsController < ApplicationController
  before_action :set_rental
  after_action :authorize_review

  def new
    @review = Review.new
    @review.rental = @rental
  end

  def create
    @review = Review.new(review_params)
    @review.rental = @rental
    if @review.save
      redirect_to rentals_path
    else

      render :new
    end
  end

  private

  def set_rental
    @rental = Rental.find(params[:rental_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def authorize_review
    authorize @review
  end
end
