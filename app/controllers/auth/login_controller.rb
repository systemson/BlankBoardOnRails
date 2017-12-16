class Auth::LoginController < FrontController
  before_action :require_guest, except: [:logout]
  require 'date'

  def login
    @user = auth_user
  end

  def auth

    user = User.find_by_user(params[:user])

    if user && user.authenticate(params[:password])

      user.remember_token = token
      user.last_login = Date.today
      user.save

      session[:user_id] = user.id
      session[:user_password] = params[:password]

      redirect_to admin_dashboard_path
    else

      #redirect_back fallback_location: login_path
    end
  end

  def logout
    user = User.find(session[:user_id])
    user.remember_token = nil
    user.save

    reset_session
    redirect_to login_path
  end

  def register
  end
end
