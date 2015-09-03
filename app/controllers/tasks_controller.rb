class TasksController < ApplicationController
  def new
    @task = Task.new
    @users = User.all
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = "Created Task!"
      redirect_to(users_url)
    else
      render 'new'
    end
  end
  private
  def task_params
    params.require(:task).permit(:content, :user_id, :at)
  end
end
