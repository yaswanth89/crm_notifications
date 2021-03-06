class UsersController < ApplicationController
  before_action :logged_in_user, only: [:tasks,:show,:reminders,:notifications]
  before_action :correct_user, only: [:show]
  before_action :admin_user, only: [:roaster,:update_roaster,:index,:get_available_users]
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.order(:at)
  end

  def roaster
    @user = User.find(params[:id])
  end

  def update_roaster
    @user = User.find(params[:id])
    @user.mand_off = roaster_params[:mand_off]
    @user.save!
    redirect_to @user
  end

  def tasks
    render :json => current_user.tasks
  end

  def holiday
    @user = User.find(params[:id])
  end

  def create_holiday
    @user = User.find(params[:id])
    @user.holidays.create(holiday_params)
    redirect_to @user
  end

  def get_available_users
    @date = Date.parse(params[:date])
    week_day = @date.cwday % 7
    @users  = User.where.not(mand_off: week_day).select { |e| 
      if(e.holidays.count != 0)
        e.holidays.where(at: @date).count == 0 
      else
        true
      end
    }
  end




  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def roaster_params
    params.require(:roaster).permit(:mand_off)
  end

  def holiday_params
    params.require(:holiday).permit(:at)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
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