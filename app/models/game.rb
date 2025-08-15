class Game < ApplicationRecord
  belongs_to :user
  has_many :guesses, dependent: :destroy, inverse_of: :game

  enum :status, { in_progress: 0, win: 1, loss: 2 }

  validates :solution,
            presence: true,
            length: { is: 4 },
            format: { with: /\A[0-7]{4}\z/, message: "must be exactly 4 digits between 0 and 7" }

  def break_code(guess)
    report = { exact_match: 0, number_match: 0 }

    # Step 1: Exact matches
    solution_remaining = []
    guess_remaining = []

    (0...solution.length).each do |i|
      if solution[i] == guess[i]
        report[:exact_match] += 1
      else
        solution_remaining << solution[i]
        guess_remaining << guess[i]
      end
    end

    # Step 2: Number matches
    solution_counts = solution_remaining.tally  # { number => count }
    guess_remaining.each do |g|
      if solution_counts[g] && solution_counts[g] > 0
        report[:number_match] += 1
        solution_counts[g] -= 1
      end
    end

    report
  end
end
