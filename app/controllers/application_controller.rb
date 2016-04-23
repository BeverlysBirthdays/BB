class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # just show a flash message instead of full CanCan exception
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You are not authorized to take this action."
    redirect_to about_path
  end

  # handle missing pages the BSG way...
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render template: 'errors/not_found'
  end

end
