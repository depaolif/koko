class ArtistsController < ApplicationController

  def create
  end

  def trending
    @trending_artists = Artist.trending_artists
    render :trending
  end

  def show
    @artist = Artist.find_by(id: params[:id])
    @artist_songs_ordered_by_review = @artist.trending_songs
  end

end
