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
      artists << artist_name
    end
    self.artist = artists[0]
  end

  def all_artists(song_data)
    song_data["artists"].map do |artist|
      artist["name"]
    end
  end

  def weighted_review_average
    weighted_averages = []
    self.reviews.each do |review|
      if review.song_score
        weighted_averages << (review.song_score * review.weighted_score)
      end
    end
    summed_score = weighted_averages.inject(0){|sum,x| sum + x }
    review_count = self.reviews.count
    weighted_average = summed_score/review_count
    weighted_average.to_f
  end


end
