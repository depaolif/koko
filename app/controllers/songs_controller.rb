class SongsController < ApplicationController
  helper_method :my_review_for_song

  def create
  end

  def show
    @song = Song.find_by(id: params[:id])
    @review = Review.new
  end


  def vote
    vote = Vote.new(score: vote_attributes[:vote], review_id: vote_attributes[:review_id].to_i)
    vote.account_id = current_user.id
    vote.save
    if vote.save
      ActionCable.server.broadcast 'upvotes',
        score: vote.score,
        review_id: vote.review_id
      head :ok
    end
    # redirect_to song_path(params[:song_id])
  end

  def change_vote
    vote = Vote.where(account_id: current_user.id, review_id: params[:review_id]).first
    prev = vote.score
    vote.update(score: vote_attributes[:vote])
    if vote.save
      ActionCable.server.broadcast 'upvotes',
        score: vote.score,
        review_id: vote.review_id,
        prev: prev
      head :ok
    end
    # redirect_to song_path(params[:song_id])
  end

  private
  def vote_attributes
    params.permit(:vote, :review_id, :account_id)
  end

  def my_review_for_song(song, current_user)
    song.reviews.find {|review| review.account_id == current_user.id}
  end

end
