class ApplicationController < ActionController::Base
  include Pundit
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :not_authorize
  before_action :find_user
  helper_method :user_signed_in?, :current_user

  private

  # 處理N+1問題?
  def find_user
    if session[:user_token]
      @current_user = User.find(session[:user_token])
    end
  end

  def not_found
    render file: "/public/404.html", status: 404, layout: false
  end

  # 使用者是否有登入
  def user_signed_in?
    # session[:user_token]
    current_user != nil
  end

  # 使用者是誰，沒有的話是nil
  def current_user
    @current_user ||= User.find_by(id: session[:user_token])
  end

  # 沒有登入自動轉址到登入頁面
  def authenticate_user!
    redirect_to root_path, notice: "請登入會員" if not user_signed_in?
  end

  private

  def not_authorize
    redirect_to root_path, notice: "權限不足或請付款"
  end
end
