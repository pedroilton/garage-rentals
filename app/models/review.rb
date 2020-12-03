class Review < ApplicationRecord
  belongs_to :rental

  validates :rating, presence: true, inclusion: { in: 1..5 }
end
