Rails.application.routes.draw do
  namespace :admin do
    get "users/edit"
    get "users/update"
    get "dashboard/index"
  end
  devise_for :users,controllers: { sessions: "users/sessions" ,registrations: "users/registrations"}
  patch "dashboard/update_icon", to: "dashboard#update_icon", as: "update_icon"

  devise_scope :user do
   root "devise/sessions#new"
  end
  
  authenticated :user do
    root "dashboard#index", as: :authenticated_root 
  end

  namespace :admin do
    get "dashboard", to: "dashboard#index"
    resources :users
  end
  
  get "dashboard/edit_profile", to: "dashboard#edit", as: "edit_profile"
  patch "dashboard/update_profile", to: "dashboard#update", as: "update_profile"
  get "dashboard", to: "dashboard#index"  
end
