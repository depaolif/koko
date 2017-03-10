class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def home
  end

  def logged_in?(session)
    !!session[:account_id]
  end

  def current_user
    @account ||= Account.find_by_id(session[:account_id])
  end

end
