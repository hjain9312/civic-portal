class Users::RegistrationsController < Devise::RegistrationsController
  # For Authorities
  def new_authority
    @user = User.new
    render :new_authority
  end

  def create_authority
    process_registration('authority', authority_dashboard_path, :new_authority)
  end

  # For Normal Users
  def new_normal_user
    @user = User.new
    render :new_normal_user
  end

  def create_normal_user
    process_registration('normal_user', normal_user_dashboard_path, :new_normal_user)
  end

  private

  # Common logic for registration
  def process_registration(role, success_redirect_path, failure_render_view)
    @user = User.new(user_params)
    @user.role = role  # Assign the role dynamically

    if @user.save
      sign_in @user  # Automatically sign in after successful registration
      redirect_to success_redirect_path, notice: "#{role.titleize} account created successfully!"
    else
      flash.now[:alert] = "There were errors in your registration details."
      render failure_render_view, status: :unprocessable_entity
    end
  end

  # Permit the required user attributes (email, password, password_confirmation)
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end