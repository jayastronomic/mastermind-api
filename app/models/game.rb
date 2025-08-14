class Game < ApplicationRecord
  belongs_to :user
  has_many :guesses

  validates :solution,
            presence: true,
            length: { is: 4 },
            format: { with: /\A[0-7]{4}\z/, message: "must be exactly 4 digits between 0 and 7" }
end
