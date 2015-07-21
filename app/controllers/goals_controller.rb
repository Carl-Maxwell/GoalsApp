class GoalsController < ApplicationController
  before_action :require_owner, only: [:edit, :update, :destroy]

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def index
    @user = User.find(params[:user_id])
    @goals = @user.goals

    if params[:completed] == 'false'
      @goals = @goals.where(completed: false)
    elsif params[:completed] == 'true'
      @goals = @goals.where(completed: true)
    end

    if current_user != @user
      @goals = @goals.where(public_goal: true)
    end
  end

  def show
    @goal = Goal.find(params[:id])

    if current_user != @goal.user
      redirect_to user_goals_url(@goal.user) unless @goal.public_goal
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_goals_url(@goal.user)
  end

  private
  def goal_params
    the_params = params.require(:goal).permit(:name, :user_id, :public_goal, :completed)
    the_params[:public_goal] = (the_params[:public_goal] == "true")
    the_params[:completed] = !!the_params[:completed]
    the_params
  end

  def require_owner
    @goal = Goal.find(params[:id])
    redirect_to user_goals_url(@goal.user) unless current_user = @goal.user
  end
end
