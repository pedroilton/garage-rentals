class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :garage

  has_many :reviews

  # validates :start_date, presence: true
end
