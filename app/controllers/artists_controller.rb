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

    # @artist_songs_ordered_by_review = {}
    # @artist.songs.each do |song|
    #   if song.reviews.count > 0
    #     @artist_songs_ordered_by_review[song] = song.weighted_average.round(2)
    #   end
    # end
    # @artist_songs_ordered_by_review = Hash[@artist_songs_ordered_by_review.sort_by{|k, v| v}.reverse]
  end

end
