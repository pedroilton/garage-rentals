class Garage < ApplicationRecord
  belongs_to :user

  has_many :rentals
  has_many :reviews, through: :rentals

  validates :user_id, presence: true
  validates :title, presence: true
  validates :price, presence: true
  validates :address, presence: true
end
