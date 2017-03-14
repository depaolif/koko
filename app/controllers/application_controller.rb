class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def home
      trending_songs
    if logged_in?
      influencers_picks
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

  def logged_in?
    !!session[:account_id]
  end

  def current_user
    @account ||= Account.find_by_id(session[:account_id])
  end

  def influencers_picks
    array = upvoted_accounts
    @final_array = []
    unordered_influencer_list = array.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    sorted_influencer_list = Hash[unordered_influencer_list.sort_by{|k, v| v}.reverse]
    sorted_influencer_list.each do |reviewer, frequency|
      if reviewer.reviews.where("song_score > ?", 3).last
        @final_array << [reviewer, reviewer.reviews.where("song_score > ?", 3).last]
      end
    end
    if @final_array.size > 10
      @final_array = final_array[0..10]
    else
      @final_array
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
    @friends_reviews
  end


  def upvoted_accounts
    Account.joins(:votes).where(votes: {account_id: current_user.id}).where(votes: {score: 1})
  end

end
