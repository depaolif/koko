class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :review_id
      t.integer :account_id
      t.integer :score

      t.timestamps
    end
  end
end
