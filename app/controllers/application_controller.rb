class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  before_action :find_user
  helper_method :user_signed_in?, :current_user

  private

  def find_user
    if session[:user_token]
      @current_user = User.find(session[:user_token])
    end
  end

  def not_found
    render file: "/public/404.html", status: 404, layout: false
  end

  def user_signed_in?
    # session[:user_token]
    current_user != nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_token])
  end

  def authenticate_user!
    redirect_to root_path, notice: "請登入會員" if not user_signed_in?
  end
end
