module AuthHelper
  def token
    token = SecureRandom.urlsafe_base64
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

  def auth_user
    if(session[:user_id].present?)
      user = User.find(session[:user_id])
    else
      nil
    end
  end
end
