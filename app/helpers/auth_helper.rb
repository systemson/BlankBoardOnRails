module AuthHelper

  def token
    SecureRandom.urlsafe_base64
  end

  def auth_check
    if(session[:user_id].present?)
      true
    else
      false
    end
  end

  def guest
    if(session[:user_id].present?)
      false
    else
      true
    end
  end

  def current_user
    if(session[:user_id].present?)
      user = User.find(session[:user_id])
    else
      nil
    end
  end

  def require_login
    unless session[:user_id].present?
      redirect_to login_url
    end
  end

  def require_guest
    if session[:user_id].present?
      redirect_to admin_dashboard_path
    end
  end
end
