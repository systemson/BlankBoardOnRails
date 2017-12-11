class Auth::LoginController < ApplicationController
  #include Authentication

  layout 'admin'

  def login
  end

  def auth

    user = User.find_by_user(params[:user])

    if user && user.authenticate(params[:password])

      session[:user_id] = user.id
      session[:user_password] = params[:password]

      redirect_to admin_dashboard_path
    else

      #redirect_back fallback_location: login_path
    end
  end

  def logout

    reset_session
    redirect_to login_path

  end

  def register
  end
end
