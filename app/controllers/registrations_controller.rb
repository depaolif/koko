class RegistrationsController < ApplicationController
  def new
    @account = Account.new
  end

  def create
    account = Account.new(account_params)
    account.save
    session[:account_id] = account.id
    redirect_to home_path
  end

  private

  def account_params
    params.require(:account).permit(:user_name, :password)
  end
end
