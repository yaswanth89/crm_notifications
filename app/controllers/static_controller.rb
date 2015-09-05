class StaticController < ApplicationController
  before_action :logged_in_user, only: [:available_users]
  before_action :admin_user, only: [:available_users]
  def home
  end
  def available_users
  end
  private 
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def admin_user
    unless current_user.admin?
      flash[:danger] = "Unauthorized access."
      redirect_to(root_url) 
    end
  end
end