module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :user_signed_in?, :current_user
  end

  private

  def authenticate_user!
    return if user_signed_in?

    redirect_to new_session_path, danger: 'You must log in'
  end

  def user_signed_in?
    current_user.present?
  end

  def current_user
    Current.user ||= authenticate_user_from_session
  end

  def authenticate_user_from_session
    User.find_by(id: session[:user_uuid])
  end

  def login(user)
    Current.user = user

    reset_session

    session[:user_uuid] = user.id
  end

  def logout
    Current.user = nil

    reset_session
  end
end
