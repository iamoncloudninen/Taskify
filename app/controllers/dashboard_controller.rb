class DashboardController < ApplicationController
  def show
    current_time = Time.zone.now
    @upcoming_tasks = current_user.tasks
    .where(completed: false)
    .where('deadline >= ?', current_time)
    .order(priority: :desc, deadline: :asc)
    @outdated_tasks = current_user.tasks
    .where(completed: false)
    .where('deadline < ?', current_time)
    @completed_tasks_today = current_user.tasks.where(completed: true, completed_at: current_time.beginning_of_day..current_time.end_of_day)
  end
end
