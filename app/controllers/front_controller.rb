class FrontController < ApplicationController
  before_action :require_guest

  layout 'admin'
end