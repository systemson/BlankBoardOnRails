class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include AuthHelper

  before_action :set_variables
  layout 'admin'

  def set_variables
    @auth_user = auth_user
  end
end
