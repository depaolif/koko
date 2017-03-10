class SpotifyApiController < ApplicationController

  def search
    binding.pry
    SpotifyApi.new(spotify_params)
    
  end

  private
  def spotify_params
    params.permit("query")
  end
end
