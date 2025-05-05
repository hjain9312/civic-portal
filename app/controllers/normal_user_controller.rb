class NormalUserController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_normal_user

  def dashboard
    user_complaints = current_user.complaints
    @complaints_count = user_complaints.count
    @pending_count =  user_complaints.where(status: "pending").count
    @resolved_count = user_complaints.where(status: "resolved").count
    @recent_complaints = user_complaints.order(created_at: :desc).limit(5)
  end
  

  def profile
    @profile = current_user
  end

  def edit_profile
    @profile = current_user
  end

  def update_profile
    @profile = current_user
    if @profile.update(user_params)
      redirect_to normal_user_profile_path, notice: 'Profile updated successfully.'
    else
      render :edit_profile, status: :unprocessable_entity
    end
  end

  def complaints
    @complaints = current_user.complaints
  end

  private

  def ensure_normal_user
    redirect_to root_path, alert: "Access denied." unless current_user.normal_user?
  end

  def user_params
    # Only allow the fields you really need for a normal user to update
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :latitude, :longitude)
  end
end
