class DashboardController < ApplicationController
  def show
    current_time = Time.zone.now
    @upcoming_tasks = fetch_tasks(completed: false, deadline: current_time.., order: { priority: :desc, deadline: :asc })
    @outdated_tasks = fetch_tasks(completed: false, deadline: ...current_time)
    @completed_tasks_today = fetch_tasks(completed: true, completed_at: current_time.all_day)
  end

  private

  def fetch_tasks(completed:, deadline: nil, completed_at: nil, order: nil)
    tasks = current_user.tasks.where(completed: completed)
    tasks = tasks.where(deadline: deadline) if deadline
    tasks = tasks.where(completed_at: completed_at) if completed_at
    tasks = tasks.order(order) if order
    tasks
  end
end
