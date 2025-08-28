class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

    before_action :configure_sign_up_params, only: [ :create ]

    protected


    # This method overrides the default behavior of updating a user's resource (e.g., their profile).
    def update_resource(resource, params)
      params.except!(:password, :password_confirmation) if params[:password].blank?

      resource.update_without_password(params)
    end


    # This method is called before any action to set up permitted parameters for account updates.
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name email dob gender icon])
    end

    # This method is specifically called before the create action to set up permitted parameters for user sign-up.

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :email, :password, :password_confirmation, :dob, :gender, :icon ])
    end
end
