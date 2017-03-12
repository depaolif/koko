class ArtistsController < ApplicationController

  def create
  end

  def index
    artists = Artist.all
    trending_artists_hash = {}
    @trending_artists = []
    average_score = 0
    artists.each do |artist|
      if artist.reviews.count > 0
      average_score = artist.reviews.sum(:song_score).to_f/artist.reviews.count(:song_score)
        trending_artists_hash[artist] = average_score
        trending_artists_hash.map do |h|
          @trending_artists << h
      end
      end
    end
  end

  def show
    @artist = Artist.find_by(id: params[:id])
  end

end
