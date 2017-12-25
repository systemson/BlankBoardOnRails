class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_variables
  include AuthHelper

  def set_variables
    @current_user = current_user
    @auth_check = auth_check
    @guest = guest
  end

  def current_controller?(names)
    names.include?(controller_name) unless controller_name.blank? || false
   end

  helper_method :current_controller?

end
