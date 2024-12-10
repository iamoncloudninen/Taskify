class ReactionsController < ApplicationController
  before_action :find_post

  def create
    unless @post.reactions.exists?(user: current_user)
      @post.reactions.create(user: current_user)
      flash[:notice] = "頑張ったね！"
    else
      flash[:alert] = "すでに頑張ったね！を送っています。"
    end
    redirect_to timeline_index_path
  end

  def destroy
    reaction = @post.reactions.find_by(user: current_user)
    if reaction
      reaction.destroy
      flash[:notice] = "頑張ったね！を取り消しました。"
    end
    redirect_to timeline_index_path
  end

  private

  def find_post
    @post = TimelinePost.find(params[:timeline_post_id])
  end
end

