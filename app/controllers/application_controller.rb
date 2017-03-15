class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def home
      influencers_picks
    if logged_in?
      suggested_picks
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
    accounts = Account.all
    unordered_influencers_hash = {}
    @influencers_last_good_review = []
    accounts.each do |account|
      unordered_influencers_hash[account] = account.vote_total
    end
    ordered_influencers_hash = Hash[unordered_influencers_hash.sort_by{|k, v| v}.reverse]
      influencers = ordered_influencers_hash.keys
      influencers.each do |influencer|
        if influencer.reviews.count > 0 && influencer.reviews.any? {|review| review.song_score > 3} && influencer != current_user
          @influencers_last_good_review << influencer.reviews.where("song_score > ?", 2).last
        end
    end
    if @influencers_last_good_review.count > 20
      @influencers_last_good_review[0..20]
    else
      @influencers_last_good_review
    end
  end

  def logged_in?
    !!session[:account_id]
  end

  def current_user
    @account ||= Account.find_by_id(session[:account_id])
  end

  def suggested_picks
    array = upvoted_accounts
    @suggested_array = []
    unordered_suggested_list = array.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    sorted_suggested_list = Hash[unordered_suggested_list.sort_by{|k, v| v}.reverse]
    sorted_suggested_list.each do |reviewer, frequency|
      if reviewer.reviews.where("song_score > ?", 3).last
        @suggested_array << [reviewer, reviewer.reviews.where("song_score > ?", 3).last]
      end
    end
    if @suggested_array.size > 10
      @suggested_array = @suggested_array[0..10]
    else
      @suggested_array
    end
  end

  def friends_reviews
    current_user_friends_reviews = []
    current_user.friends.each do |friend|
      friend.friend.reviews.each do |review|
        current_user_friends_reviews << review
      end
    end
    @friends_reviews = current_user_friends_reviews.sort
    @friends_reviews = @friends_reviews[0..100]
  end


  def upvoted_accounts
    Account.joins(:votes).where(votes: {account_id: current_user.id}).where(votes: {score: 1})
  end

end
