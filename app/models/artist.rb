class Artist < ApplicationRecord
  has_many :songs
  has_many :reviews, through: :songs


  def self.trending_artists
    Artist.select("artists.*, AVG(weighted_score)").joins(songs: :reviews).group("artists.id").having('AVG(weighted_score) > ?', 3).order('AVG(weighted_score) DESC')
  end

  def trending_songs
    Song.where("songs.artist_id = ?", self.id).select("songs.*, AVG(weighted_score)").joins(:reviews).group("songs.id").having('AVG(weighted_score) > ?', 3).order('AVG(weighted_score) DESC')
  end

  def self.delete_unused
    Artist.includes(:songs).where('id NOT IN (SELECT DISTINCT (song_id) FROM reviews)').delete_all
  end

end
