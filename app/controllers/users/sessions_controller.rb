class Users::SessionsController < Devise::SessionsController
    def create
      if params[:user][:email].blank? && params[:user][:password].blank?
        flash.now[:alert] = "Email and Password are required."
        self.resource = User.new(sign_in_params)
        render :new, status: :unprocessable_entity and return
      elsif params[:user][:email].blank?
        flash.now[:alert] = "Email is required."
        self.resource = User.new(sign_in_params)
        render :new, status: :unprocessable_entity and return
      elsif params[:user][:password].blank?
        flash.now[:alert] = "Password is required."
        self.resource = User.new(sign_in_params)
        render :new, status: :unprocessable_entity and return
      end
  
      self.resource = warden.authenticate(auth_options)
      
      if resource
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        respond_with resource, location: after_sign_in_path_for(resource)
      else
        flash.now[:alert] = "Invalid Email or Password."
        self.resource = User.new(sign_in_params)
        render :new, status: :unprocessable_entity
      end
    end
  
  end