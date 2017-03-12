class Song < ApplicationRecord
  has_many :reviews
  has_many :accounts, through: :reviews
  belongs_to :artist

  def song_data=(song_data)
    self.name = song_data["name"]
    self.play_url = song_data["uri"]
    self.spotify_song_id = song_data["id"]
    self.album_name = song_data["album"]["name"]
    all_artists(song_data).each do |artist_name|
      self.artist = Artist.find_or_create_by(name: artist_name)
    end
  end

  def all_artists(song_data)
    song_data["artists"].map do |artist|
      artist["name"]
    end
  end


end
