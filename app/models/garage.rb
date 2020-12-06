class Garage < ApplicationRecord
  belongs_to :user

  has_many :rentals, dependent: :destroy
  has_many :reviews, through: :rentals
  has_many_attached :photos

  validates :user_id, presence: true
  validates :title, presence: true
  validates :price, presence: true
  validates :address, presence: true

  def rating
    return nil if reviews.reject(&:nil?).empty?

    (reviews.inject(0.0) { |sum, review| sum + review.rating unless review.nil? } / reviews.reject(&:nil?).count).round
  end
end
