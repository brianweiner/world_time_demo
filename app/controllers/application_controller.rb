class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def current_user
    @current_user ||= super || GuestUser.new
  end

  def user_signed_in?
    super && !current_user.is_a?(GuestUser)
  end
end
