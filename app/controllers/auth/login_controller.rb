class Auth::LoginController < ApplicationController
  layout 'admin'

  def login

  end

  def auth

    user = User.find_by_user(params[:user])

    if user && user.authenticate(params[:password])
      redirect_to admin_dashboard_path
    else

      #redirect_back fallback_location: login_path
    end
  end

  def register
  end
end
