class SessionsController < ApplicationController

  def new
    @account = Account.new
  end

  def create
    binding.pry
    @account = Account.find_by(user_name: params[:account][:user_name])
    if @account.authenticate(params[:account][:password])
      session[:account_id] = @account.id
      redirect_to home_path
    else
      redirect_to home_path
    end
  end

  def destroy
    session[:account_id] = nil
    redirect_to home_path
  end

end
