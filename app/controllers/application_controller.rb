class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def home
      influencers_picks
    if logged_in?
      @suggested_picks = current_user.suggested
      friends_reviews
    end
  end

  def search
    if logged_in?
      @friends = current_user.friends
      redirect_to root_path, alert: "Oops! Please re-enter your search."
    end
  end

  def influencers_picks
    influencers = Account.influencers
      last_good_review = []
      influencers.includes(:songs).each do |influencer|
        if influencer != current_user
          last_good_review << influencer.reviews.where("song_score > ?", 2).find{|review| review.vote_sum > 1}
        end
    end
      @influencers_last_good_review = last_good_review.compact
  end

  def friends_reviews
    current_user_friends_reviews = []
    current_user.friends.each do |friend|
      friend.friend.reviews.includes(:song).each do |review|
        current_user_friends_reviews << review
      end
    end
    @friends_reviews = current_user_friends_reviews.sort
    @friends_reviews = @friends_reviews[0..100].reverse
  end

  def logged_in?
    !!session[:account_id]
  end

  def current_user
    @account ||= Account.find_by_id(session[:account_id])
  end

end
