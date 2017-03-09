class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :account_id
      t.integer :song_id
      t.string :content
      t.integer :song_score

      t.timestamps
    end
  end
end
