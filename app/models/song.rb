class Song < ApplicationRecord
  has_many :reviews
  has_many :accounts, through: :reviews
  belongs_to :artist

  def song_data=(song_data)
    artists = []
    self.name = song_data["name"]
    self.play_url = song_data["uri"]
    self.spotify_song_id = song_data["id"]
    self.album_name = song_data["album"]["name"]
    all_artists(song_data).each do |artist_name|
      artists << Artist.find_or_create_by(name: artist_name)
    end
    self.artist = artists[0]
  end

  def all_artists(song_data)
    song_data["artists"].map do |artist|
      artist["name"]
    end
  end


  def weighted_average
    if self.reviews
      weighted_scores = self.reviews.map do |review|
        review.weighted_score
      end
      total_weighted_scores = weighted_scores.reduce(:+)
      count_weighted_scores = weighted_scores.count
      average_weighted_score = total_weighted_scores / count_weighted_scores
    else
      0
    end
  end

end
