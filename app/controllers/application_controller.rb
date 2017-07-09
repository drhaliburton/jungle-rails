class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def authorize
    redirect_to '/session/new' unless current_user
  end

  private

  def require_login
    unless session[:user_id]
      flash[:error] = "You must be logged in to access this section"
      redirect_to '/login' # halts request cycle
    end
  end

  def cart
    # value = cookies[:cart] || JSON.generate({})
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

  def admin_auth
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(username, ENV['ADMIN_USERNAME']) &&
      ActiveSupport::SecurityUtils.secure_compare(password, ENV['ADMIN_PASSWORD'])
    end  
  end
  helper_method :admin_auth
end