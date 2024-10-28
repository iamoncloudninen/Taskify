class DashboardController < ApplicationController
  def show
    @upcoming_tasks = Task.where('deadline >= ?', Date.today)
    @completed_tasks_today = Task.where(status: true)
  end
end
