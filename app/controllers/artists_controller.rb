class ArtistsController < ApplicationController

  def create
  end

  def index
    # binding.pry
    artists = Artist.joins(songs: :reviews)
    @trending_artists = {}
    artists.each do |artist|
      artist.songs.each do |song|

        Song.where("weighted_review_average > 3").includes(:artist)
        if song.reviews.count > 0 && (song.weighted_review_average.round(2) > 3)
          if song.reviews.any?{|review| review.created_at > 2.weeks.ago}
            @trending_artists[song.artist] = song.weighted_review_average.round(2)
          end
        end
      end
    end
    # Artist.joins(:songs).where("songs.weighted_review_average > 3").order("songs.weighted_review_average")
    @trending_artists = Hash[@trending_artists.sort_by{|k, v| v}.reverse]
    # binding.pry
  end

  def show
    @artist = Artist.find_by(id: params[:id])
    @artist_songs_ordered_by_review = {}
    @artist.songs.each do |song|
      if song.reviews.count > 0
        @artist_songs_ordered_by_review[song] = song.weighted_review_average.round(2)
      end
    end
    @artist_songs_ordered_by_review = Hash[@artist_songs_ordered_by_review.sort_by{|k, v| v}.reverse]
  end

end
