class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_filter means to run this method before any other action
  before_filter :authenticate_user

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  helper_method :current_user

  def authenticate_user
    # shortcut for @current_user || @current_user = User.find....
    # @current_user ||= User.find(session[:user_id])

    current_user
  rescue ActiveRecord::RecordNotFound
    redirect_to new_session_path and return false # indicate that the filter failed, halt execution of home route
  end
end
