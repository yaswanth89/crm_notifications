class TasksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:show]

  def new
    @task = Task.new
    @users = User.all
  end

  def create
    check = task_params
    check[:at] = Time.parse(check[:at])
    @task = Task.new(check)
    if @task.save
      flash[:success] = "Created Task!"
      @task.notify_user('notify')
      redirect_to(root_url)
    else
      render 'new'
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  

  private
  def task_params
    params.require(:task).permit(:content, :user_id, :at)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    @user = Task.find(params[:id]).user
    unless current_user?(@user) || current_user.admin?
      flash[:danger] = "Unauthorized access."
      redirect_to(root_url) 
    end
  end

  def admin_user
    unless current_user.admin?
      flash[:danger] = "Unauthorized access."
      redirect_to(root_url)
    end
  end
end
