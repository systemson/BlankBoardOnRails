class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #include SessionsHelper

  layout 'admin'
end
