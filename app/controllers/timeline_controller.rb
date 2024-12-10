class TimelineController < ApplicationController
  before_action :authenticate_user!

  def index
    @timeline_posts = TimelinePost.all.order(created_at: :desc)
  end

  def new
    current_time = Time.zone.now
    @tasks = current_user.tasks.where(completed: true, completed_at: current_time.beginning_of_day..current_time.end_of_day)
    @timeline_post = TimelinePost.new
  end

  def create
    @timeline_post = TimelinePost.new(timeline_post_params)
    @timeline_post.user = current_user

    if @timeline_post.save
      redirect_to timeline_index_path, notice: '投稿しました。'
    else
      render :new
    end
  end

  def destroy
    @timeline_post = TimelinePost.find(params[:id])
    if @timeline_post.destroy
      flash[:notice] = "投稿を削除しました。"
      redirect_to request.referer
    end
  end

  private
  def timeline_post_params
    params.require(:timeline_post).permit(:content, task_ids: [], images: [])
  end
end
