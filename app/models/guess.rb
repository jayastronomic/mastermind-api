class Guess < ApplicationRecord
  belongs_to :game

  validates :location_match,
            :number_match,
            presence: true,
            numericality: { in: 1..4, only_integer: true },
            on: :create

  validates :value,
            presence: true,
            length: { is: 4 },
            format: { with: /\A[0-7]{4}\z/, message: "must be exactly 4 digits between 0 and 7" },
            on: :value_only
end
