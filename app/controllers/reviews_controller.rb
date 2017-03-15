class ReviewsController < ApplicationController
  protect_from_forgery except: :new

  def new
    # allows people to still use the new page, but only if they haven't already written a review, otherwise it redirects
    set_song
    if user_has_reviewed?
      redirect_to @song
    else
      if @song
        @review = Review.new
        render 'new'
      end
    end
  end

  def create
    @review = Review.new(review_params)
    set_song
    @review.song = @song
    @review.account = current_user
    if @review.save && @review.valid?
      vote = Vote.new(score: 1, review_id: @review.id, account_id: current_user.id)
      vote.save
      redirect_to @song
    else
      redirect_to @song, alert: "Please make sure you give your review 1 to 5 stars."
    end
  end

  def edit
    set_review
    set_song
    if @review.account_id == current_user.id
      render 'edit'
    else
      redirect_to @song
    end
  end

  def update
    set_review
    set_song
    if @review.update(review_params) && @review.valid?
      @review.votes.each{|vote| vote.destroy}
      vote = Vote.new(score: 1, review_id: @review.id, account_id: current_user.id)
      vote.save
      redirect_to @song
    else
      redirect_to @song
    end
  end

  def destroy
    set_review
    set_song
    @review.votes.each{|vote| vote.destroy}
    @review.destroy
    redirect_to song_path(params[:song_id])
  end

  private
  def review_params
    params.require('review').permit('account_id','song_id', 'content','song_score')
  end

  def set_song
    @song = Song.find_by(id: params[:song_id])
  end

  def set_review
    @review = Review.find_by(id: params[:id])
  end

  def user_has_reviewed?
    set_song
    current_user.reviews.any? { |review| review.song_id == @song.id }
  end

  def validate_form_input(input)
    if !!input.scan(/[<>]/).empty?
    else
      input.gsub(/\s+$/,'')
    end
  end

end
