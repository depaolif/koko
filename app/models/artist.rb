class Artist < ApplicationRecord
  has_many :songs
  has_many :reviews, through: :songs


  def self.trending
    Artist.select("artists.*, AVG(weighted_score)").joins(songs: :reviews).group("artists.id").having('AVG(weighted_score) > ?', 3).order('AVG(weighted_score) DESC')
  end

end
