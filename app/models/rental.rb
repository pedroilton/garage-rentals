class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :garage

  has_one :review, dependent: :destroy

  validates :start_date, presence: true
  validates_inclusion_of :start_date, in: Date.today..
end
