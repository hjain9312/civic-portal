class Users::SessionsController < Devise::SessionsController
  # New authority login form
  def new_authority
    @user = User.new
    render :new_authority
  end

  # Process authority login
  def create_authority
    process_login(:user, User, authority_dashboard_path, :new_authority, 'authority')
  end

  # New normal user login form
  def new_normal_user
    @user = User.new
    render :new_normal_user
  end

  # Process normal user login
  def create_normal_user
    process_login(:user, User, normal_user_dashboard_path, :new_normal_user, 'normal_user')
  end

  private

  # Common logic for login
  def process_login(scope, model, success_redirect_path, failure_render_view, role = nil)
    email = params.dig(scope, :email)
    password = params.dig(scope, :password)

    if email.blank? || password.blank?
      flash.now[:alert] = "Email and password can't be blank"
      instance_variable_set("@#{scope}", model.new(email: email))
      return render failure_render_view, status: :unprocessable_entity
    end

    user = model.find_by(email: email)

    if user && (role.nil? || user.role == role) && user.valid_password?(password)
      sign_in(scope, user)
      redirect_to success_redirect_path, notice: "Logged in successfully as #{role&.titleize || scope.to_s.titleize}."
    else
      flash.now[:alert] = "Invalid email or password"
      instance_variable_set("@#{scope}", model.new(email: email))
      render failure_render_view, status: :unprocessable_entity
    end
  end
end