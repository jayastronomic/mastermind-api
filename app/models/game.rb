class Game < ApplicationRecord
  belongs_to :user
  has_many :guesses, dependent: :destroy, inverse_of: :game

  enum :status, { in_progress: 0, win: 1, loss: 2 }

  validates :solution,
            presence: true,
            length: { is: 4 },
            format: { with: /\A[0-7]{4}\z/, message: "must be exactly 4 digits between 0 and 7" }

  def break_code(guess)
    guesses << guess
    value = guess.value

    # Step 1: Location matches
    solution_remaining = []
    guess_remaining = []

    (0...solution.length).each do |i|
      if solution[i] == value[i]
        guess.location_match += 1
      else
        solution_remaining << solution[i]
        guess_remaining << value[i]
      end
    end

    # Step 2: Number matches
    solution_counts = solution_remaining.tally  # { number => count }
    guess_remaining.each do |g|
      if solution_counts[g] && solution_counts[g] > 0
        guess.number_match += 1
        solution_counts[g] -= 1
      end
    end

    # Step 3: Get Report
    if guess.location_match == 4
      self.status = :win
    elsif guesses.length == 4
      self.status = :loss
    end
  end
end
