class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_variables
  include AuthHelper

  def set_variables
    @auth_user = auth_user
    @auth_check = auth_check
    @guest = guest
  end
end
