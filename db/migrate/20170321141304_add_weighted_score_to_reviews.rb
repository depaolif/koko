class AddWeightedScoreToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :weighted_score, :float, default: nil
  end
end
