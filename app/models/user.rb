class User < ApplicationRecord
  has_secure_password
  has_many :games, dependent: :destroy

  validates :username, presence: true, uniqueness: true

  def last_game
    games.order(created_at: :desc).first
  end
end
