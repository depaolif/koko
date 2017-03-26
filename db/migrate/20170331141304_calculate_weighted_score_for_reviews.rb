class CalculateWeightedScoreForReviews < ActiveRecord::Migration[5.0]
  def up
      reviews = Review.where("weighted_score is NULL")

      reviews.each do |review|
        review.weighted_score = review.song_score
        review.save
      end

  end

  def down
  end

end
