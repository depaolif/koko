class SpotifyApiController < ApplicationController

  def search
    # binding.pry
    search_obj = SpotifyApi.new(spotify_params[:query])
    x = search_obj.search
    if x.length > 0
      @songs = search_obj.make_songs
      render 'search_results'
    else

    end
  end

  private
  def spotify_params
    params.permit("query")
  end
end
