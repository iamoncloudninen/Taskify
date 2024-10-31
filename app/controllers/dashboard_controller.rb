class DashboardController < ApplicationController
  def show
    @upcoming_tasks = current_user.tasks.where(completed: false).where('deadline >= ?', Time.zone.today)
    @completed_tasks_today = current_user.tasks.where(completed: true, completed_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end
end
