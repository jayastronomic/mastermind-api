class Guess < ApplicationRecord
  belongs_to :game

  validates :report, presence: true, on: :create
  validates :value,
            presence: true,
            length: { is: 4 },
            format: { with: /\A[0-7]{4}\z/, message: "must be exactly 4 digits between 0 and 7" },
            on: :value_only
end
