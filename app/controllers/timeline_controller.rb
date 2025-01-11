# frozen_string_literal: true

class TimelineController < ApplicationController
  before_action :authenticate_user!

  def index
    @timeline_posts = TimelinePost.includes(:tasks, :images_attachments, :reactions).order(created_at: :desc)
  end

  def new
    @timeline_post = TimelinePost.new
    @tasks = fetch_completed_tasks_for_today
  end

  def create
    @timeline_post = current_user.timeline_post.new(timeline_post_params)

    if @timeline_post.save
      flash[:notice] = '投稿が成功しました！'
      redirect_to timeline_index_path
    else
      flash[:alert] = '投稿に失敗しました。入力内容を確認してください。'
      @tasks = fetch_completed_tasks_for_today
      render :new
    end
  end

  def destroy
    @timeline_post = TimelinePost.find(params[:id])
    return unless @timeline_post.destroy

    flash[:notice] = '投稿を削除しました。'
    redirect_to(request.referer || timeline_index_path, notice: '投稿を削除しました。')
  end

  private

  def timeline_post_params
    params.require(:timeline_post).permit(:content, task_ids: [], images: [])
  end

  def fetch_completed_tasks_for_today
    current_time = Time.zone.now
    current_user.tasks.where(completed: true, completed_at: current_time.beginning_of_day..current_time.end_of_day)
  end
end
