class ApplicationController < ActionController::Base
  before_action :require_login
  before_filter :set_locale
  protect_from_forgery with: :exception

  def set_locale
    I18n.locale = if current_user
            current_user.locale
          else
            params[:locale] || http_accept_language.compatible_language_from(I18n.available_locales)
          end
  end

  private
  
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end
end
