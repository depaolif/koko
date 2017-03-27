class SpotifyApi

  attr_accessor :query, :songs_data

  def initialize(query)
    @query = query
  end

  def search
    url = "https://api.spotify.com/v1/search?q=#{self.query}&type=track&limit=30"
    response = RestClient.send("get", url)
    raw_data = JSON.parse(response)
    @songs_data = raw_data["tracks"]["items"]
  end

  def make_songs_and_artists
    self.songs_data.map do |song_data|
      song = Song.find_or_create_by(spotify_song_id: song_data["id"])
      song.update(song_data: song_data)
      song
    end
  end
  
end
