class FriendsController < ApplicationController

  def create
    @account_to_friend = Account.find_by(id: params[:id])
    if @account_to_friend
      current_user.friends << Friend.find_or_create_by(account_id: current_user.id, friend_id: @account_to_friend.id)
      redirect_to root_path
    else
    render :'/application/home', alert: "This is not a valid user"
    end
  end

  def index
    @user = Account.find_by(id: params[:id])
    if @user
      @friends = @user.friends
    else
      redirect_to :index, alert: "Sorry, this user does not exist"
    end 
  end

  def destroy
    @account_to_unfollow = Account.find_by(id: params[:id])
    @friend = Friend.find_by(account_id: current_user.id, friend_id: @account_to_unfollow.id)
    @friend.destroy
    redirect_to root_path
  end

end
