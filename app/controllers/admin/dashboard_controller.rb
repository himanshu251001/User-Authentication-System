class Admin::DashboardController < ApplicationController

  # It typically checks if a user is logged in.
  before_action :authenticate_user!  

  #This filter checks if the authenticated user has admin privileges before allowing access to the actions in this controller.
  before_action :authorize_admin!

  # retrieves all users from the database and assigns them to an instance variable @users.
  def index
    @users = User.all
  end

  private

  # checks currently logged-in user has admin privileges or not
  def authorize_admin!
    redirect_to root_path, alert: "Access denied!" unless current_user.admin?
  end
end
