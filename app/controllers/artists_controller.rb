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
  end

  def show
    @artist = Artist.find_by(id: params[:id])
  end

end
