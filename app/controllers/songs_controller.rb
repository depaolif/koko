class SongsController < ApplicationController

  def create
  end

  def show
    @song = Song.find_by(id: params[:id])
  end


  def vote
    # binding.pry
    vote = Vote.new(score: vote_attributes[:vote], review_id: vote_attributes[:review_id].to_i)
    vote.account_id = current_user.id
    vote.save
    redirect_to song_path(params[:song_id])
  end

  private
  def vote_attributes
    params.permit(:vote, :review_id, :account_id)
  end

end
