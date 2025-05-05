class AuthoritiesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_authority

  def show_complaint
    @complaint = Complaint.find(params[:id])
    logger.debug "Complaint Location: #{@complaint.latitude}, #{@complaint.longitude}"
  end  

  def resolve
    @complaint = Complaint.find(params[:id])
    @complaint.update(status: "Resolved")
    redirect_to authority_dashboard_path, notice: "Complaint resolved."
  end

  def reject
    @complaint = Complaint.find(params[:id])
    @complaint.update(status: "Rejected")
    redirect_to authority_dashboard_path, notice: "Complaint rejected."
  end

  def ensure_authority
    redirect_to root_path, alert: "Access denied." unless current_user.authority?
  end

  def dashboard
    @user = current_user
  end

  def pending_complaints
    @pending_complaints = Complaint.where(status: 'pending')
  end

  def show_pending_complaint
    @complaint = Complaint.find(params[:id])
    # Additional logic can be added to ensure the complaint is pending if needed
  end

  def profile
    @authority = current_user
  end

  def edit_profile
    @authority = current_user
  end

  def update_profile
    @authority = current_user
    if @authority.update(authority_params)
      redirect_to authority_profile_path, notice: 'Profile updated successfully.'
    else
      render :edit_profile
    end
  end

  private

  def authority_params
    params.require(:user).permit(:name, :email)
  end
end
