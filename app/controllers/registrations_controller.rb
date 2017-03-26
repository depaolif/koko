class RegistrationsController < ApplicationController

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    if !@account.save
      redirect_to root_path, alert: "There was an error in creating your account. Make sure your password is at least 6 characters long."
    else
      session[:account_id] = @account.id
      @account.profile = Profile.create(name: "", bio: "", interests: "", account_id: current_user.id)
      redirect_to home_path
    end
  end

  def close
    redirect_to login_path if !logged_in?
  end

  def destroy
    current_user.destroy
    session[:account_id] = nil
    redirect_to home_path
  end

  private

  def account_params
    params.require(:account).permit(:user_name, :password)
  end
end
