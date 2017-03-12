class SessionsController < ApplicationController

  def new
    @account = Account.new
  end

  def create
    @account = Account.find_by(user_name: params[:account][:user_name])
    if @account && @account.authenticate(params[:account][:password])
      session[:account_id] = @account.id
      redirect_to home_path
    else
      redirect_to login_path, alert: "Username and password do not match."
    end
  end

  def destroy
    session.destroy
    redirect_to home_path
  end

end
