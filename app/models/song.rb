class Song < ApplicationRecord
  has_many :reviews
  has_many :accounts, through: :reviews

  def song_data=(song_data)
    self.name = song_data["name"]
    self.artist_name = song_data["artists"].map{|artist| artist["name"]}.join(", ")
    self.play_url = song_data["external_urls"]["spotify"]
    self.spotify_song_id = song_data["id"]
    self.album_name = song_data["album"]["name"]
  end

end
