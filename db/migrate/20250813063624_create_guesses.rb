class CreateGuesses < ActiveRecord::Migration[8.0]
  def change
    create_table :guesses, id: :uuid do |t|
      t.uuid :game_id, null: false
      t.string :report, null: false
      t.string :value, null: false

      t.timestamps
    end

    add_foreign_key :guesses, :games
  end
end
