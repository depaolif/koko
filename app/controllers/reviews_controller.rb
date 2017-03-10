class ReviewsController < ApplicationController
  def new
    @song = Song.find(params[:song_id])
    if @song
      @review = Review.new
      render 'new'
    end
  end
  def create
    @review = Review.new(review_params)
    @song = Song.find(params[:song_id])
    @review.song = @song
    @review.account = current_user
    if @review.save
      redirect_to song_path(@song)
    else
      flash[:error] = "Something went wrong with creating your review."
      redirect_to new_song_review_path
    end
  end

  private
  def review_params
    params.require('review').permit('account_id','song_id','content','song_score')
  end
end
