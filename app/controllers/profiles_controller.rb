class ProfilesController < ApplicationController
  before_action :set_profile!, only: [:show, :edit]

  def index
    @profile = Profile.find_by(user_id: current_user.id)
    render :index
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def set_profile!
      @profile = Profile.find_by(user_id: params[:id])
  end

  def profile_params
    params[:profile].permit(:name, :bio, :interests, :account_id)
  end

end
