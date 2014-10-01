class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_logged_in

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in"
      redirect_to(:controller => 'users', :action => 'index')
      return false
    else
      return true
    end
  end

  helper_method :current_user
end
