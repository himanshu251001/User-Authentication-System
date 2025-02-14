class Admin::UsersController < ApplicationController
  # Ensures that a user is logged in before accessing any action in this controller.
  before_action :authenticate_user!

  # Checks if the authenticated user has admin privileges before allowing access to the actions in this controller.
  before_action :authorize_admin!

  # This filter sets the user instance variable for the specified actions (edit, update, destroy) by finding the user based on the provided ID.
  before_action :set_user, only: [ :edit, :update, :destroy ]

  # Initializes a new user object for use in the form for creating a new user.
  def new
    @user = User.new
  end

  # Creates a new user with parameters permitted by admin_params.
  def create
    @user = User.new(admin_params)

    if @user.save
      redirect_to admin_dashboard_path, notice: "User created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end
  # Finds and assigns an existing user based on the ID passed in the parameters for editing.
  def edit
  end

  # Updates the found user with parameters permitted by user_params.
  def update
    if @user.update(user_params)
      redirect_to admin_dashboard_path, notice: "User updated successfully."
    else
      render :edit
    end
  end

  # Finds and deletes the specified user.
  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted successfully."
  end


  private

  # This method is called before certain actions (edit, update, destroy) to find and set the user instance variable based on the ID provided in parameters.
  def set_user
    @user = User.find(params[:id])
  end

  # Checks if the currently logged-in user has admin privileges.
  def authorize_admin!
    redirect_to root_path, alert: "Access denied!" unless current_user.admin?
  end

  # It specify which attributes are allowed from incoming parameters
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :dob, :gender, :role)
  end

  # It specify which attributes are allowed from incoming parameters
  def admin_params
    params.require(:user).permit(:email, :first_name, :last_name, :dob, :gender, :password, :password_confirmation, :role)
  end
end
