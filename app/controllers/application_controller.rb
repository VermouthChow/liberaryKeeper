class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def page
    params[:page] || 1
  end

  def per
    params[:per_page] || 10
  end
end
