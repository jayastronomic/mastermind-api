class UpdateGuesses < ActiveRecord::Migration[8.0]
  def change
    remove_column :guesses, :report, :string

    # Add new columns
    add_column :guesses, :location_match, :integer, default: 0, null: false
    add_column :guesses, :number_match, :integer, default: 0, null: false
  end
end
