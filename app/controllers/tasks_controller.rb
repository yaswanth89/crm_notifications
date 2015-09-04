class TasksController < ApplicationController

  def new
    @task = Task.new
    @users = User.all
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = "Created Task!"
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
    redirect_to(root_url) unless current_user?(@user)
  end
end
