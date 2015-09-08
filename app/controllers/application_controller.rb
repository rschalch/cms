class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception

  private
  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = 'Please login first!'
      redirect_to(:controller => 'access', :action => 'login')
      false
    else
      true
    end
  end
end
