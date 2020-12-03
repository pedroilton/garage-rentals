class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :garage

  has_one :review

  # validates :start_date, presence: true
end
