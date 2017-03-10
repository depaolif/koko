class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def home
  end

  def self.is_logged_in?(session)
    !!session[:account_id]
  end

  def self.current_user(session)
    @account = Account.find(session[:account_id])
  end

end
