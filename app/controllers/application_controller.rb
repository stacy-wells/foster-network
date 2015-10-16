class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    animals_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [
      :name,
      :city,
      :state,
      :description,
      :rescue_group,
      :profile_photo,
      :has_cats,
      :has_dogs
    ]

    devise_parameter_sanitizer.for(:account_update) << [
      :name,
      :city,
      :description,
      :profile_photo,
      :has_dogs,
      :has_cats
    ]
  end
end
