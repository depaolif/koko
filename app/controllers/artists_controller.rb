class ArtistsController < ApplicationController

  def create
  end

  def index
    artists = Artist.all
    @trending_artists = {}
    artists.each do |artist|
      if artist.reviews.count > 0
        @trending_artists[artist] = artist.reviews.sum(:song_score).to_f/artist.reviews.count(:song_score)
      end
    end
    @trending_artists = Hash[@trending_artists.sort_by{|k, v| v}.reverse]
  end

  def show
    @artist = Artist.find_by(id: params[:id])
    @artist_songs_ordered_by_review = {}
    @artist.songs.each do |song|
      if song.reviews.count > 0
        @artist_songs_ordered_by_review[song] = song.reviews.sum(:song_score).to_f/song.reviews.count(:song_score).round(2)
      end
    end
    @artist_songs_ordered_by_review = Hash[@artist_songs_ordered_by_review.sort_by{|k, v| v}.reverse]
  end

end
