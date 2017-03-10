class SongsController < ApplicationController

  def create
  end

  def show
    @song = Song.find_by(id: params[:id])
  end


end
