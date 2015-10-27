class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?


  after_filter :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get? 
    # sorry.
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        request.path != "/donors/sign_in" &&
        request.path != "/donors/sign_up" &&
        request.path != "/donors/password/new" &&
        request.path != "/donors/password/edit" &&
        request.path != "/donors/confirmation" &&
        request.path != "/donors/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end

  def after_sign_in_path_for(resource)
    if current_user && current_user.needs.empty?
      new_need_path
    elsif current_user
      need_path(current_user.needs.first)
    elsif current_donor
      # we need to take the donor back to the need they were looking at
      session[:previous_url]
    else
      root_path
    end
  end

  def current_organization
    Organization.first
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :image
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end
