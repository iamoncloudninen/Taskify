class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    @task.completed = false
    if @task.save
      flash[:notice] = "タスクを作成しました。"
      redirect_to dashboard_show_path
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    flash[:notice] = "タスクを更新しました。"
    redirect_to dashboard_show_path(@task)
  end

  def complete
    @task = Task.find(params[:id])
    @task.update(completed: true, completed_at: Time.zone.now)
    redirect_to dashboard_show_path, notice: 'タスクを達成しました'
  end

  def incomplete
    @task = Task.find(params[:id])
    @task.update(completed: false, completed_at: nil)
    redirect_to dashboard_show_path, notice: 'タスクを戻しました'
  end

  private
  def task_params
    params.require(:task).permit(:content, :deadline, :priority, :image)
  end
end
