class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_NAME"], password: ENV["ADMIN_PASSWORD"], except: []
  
  def show
  end
end
