class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def home
    unordered_songs = Song.all
    @unordered_songs_hash = {}
    unordered_songs.each do |song|
      if song.reviews.count > 0
        @unordered_songs_hash[song] = song.weighted_review_average.round(2)
      end
    end
      @ordered_songs_hash = Hash[@unordered_songs_hash.sort_by{|k, v| v}.reverse]
    if logged_in?
      @friends = current_user.friends
    end
  end

  def search
    if logged_in?
      @friends = current_user.friends
      redirect_to root_path, alert: "Oops! Please re-enter your search."
    end
  end


  def logged_in?
    !!session[:account_id]
  end

  def current_user
    @account ||= Account.find_by_id(session[:account_id])
  end

end
