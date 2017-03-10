class ProfilesController < ApplicationController
  before_action :set_profile!, only: :show
  before_action :set_own_profile!, only: [:index, :edit, :update]

  def index
    if @profile
      render :index
    else
      @profile = Profile.create(name: "", bio: "", interests: "", account_id: current_user.id)
      render :index
    end
  end

  def show
    if !@profile
      redirect_to root_path, alert: "This user does not exist."
    else
      render :show
    end
  end

  def edit
  end

  def update
    @profile.update(profile_params)
    render :index
  end

  private

  def set_profile!
      @profile = Profile.find_by(account_id: params[:id])
  end

  def profile_params
    params[:profile].permit(:name, :bio, :interests, :account_id)
  end

  def set_own_profile!
    @profile = Profile.find_by(account_id: current_user.id)
  end

end
