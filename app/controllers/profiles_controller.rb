class ProfilesController < ApplicationController
  before_action :set_profile!, only: :show
  before_action :set_own_profile!, only: [:index, :edit, :update]

  def show
    if !@profile
      redirect_to root_path, alert: "This user does not exist."
    end
  end

  def edit
  end

  def update
    @profile.update(profile_params)
    redirect_to show_profile_path(@profile)
  end

  private

  def set_profile!
    if !params[:id] && logged_in?
      @profile = Profile.find_by(account_id: current_user.id)
    elsif !logged_in?
      redirect_to root_path, alert: "Please log in to view this profile."
    else
      @profile = Profile.find_by(account_id: params[:id])
    end
  end

  def profile_params
    params[:profile].permit(:name, :bio, :interests, :account_id)
  end

  def set_own_profile!
    @profile = Profile.find_by(account_id: current_user.id)
  end

end
