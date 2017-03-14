class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def home
      trending_songs
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

  def trending_songs
    unordered_songs = Song.all
    @unordered_songs_hash = {}
    unordered_songs.each do |song|
      if song.reviews.count > 0 && (song.weighted_review_average.round(2) >= 3)
        @unordered_songs_hash[song] = song.weighted_review_average.round(2)
      end
    end
      @ordered_songs_hash = Hash[@unordered_songs_hash.sort_by{|k, v| v}.reverse]
  end

  def influencers_picks
    array = Account.all
    unordered_influencers_hash = {}
    vote_scores = {}
    @influencers = []
    array.each do |account|
      account.reviews.each do |review|
        vote_scores[review.account] = {sum: review.vote_sum}
      end
    end
    vote_total = vote_scores.values.inject(0) {|sum, h| sum + h[:sum] }
    unordered_influencers_hash = vote_scores.collect { |k,v| { 'sum' => v.inject(0) { |s, vv| s + vv[:sum]}} }
    sorted_influencers_list = Hash[unordered_influencers_hash.sort_by{|k, v| v}.reverse]
    sorted_influencers_list.each do |reviewer, frequency|
      if reviewer.reviews.where("song_score > ?", 3).last
        @influencers << [reviewer, reviewer.reviews.where("song_score > ?", 3).last]
      end
    end
      if @influencers.size > 10
        @influencers = @influencers[0..10]
    else
      @influencers
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
