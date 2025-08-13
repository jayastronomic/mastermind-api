class CreateGames < ActiveRecord::Migration[8.0]
  def change
    create_table :games, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.string :solution, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    add_foreign_key :games, :users
    add_index :games, :user_id
  end
end
