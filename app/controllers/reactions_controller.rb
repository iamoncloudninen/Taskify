class ReactionsController < ApplicationController
  before_action :find_post

  def create
    @timeline_posts = TimelinePost.includes(reactions: :user).all
    @post.reactions.create(user: current_user)
    flash[:notice] = "頑張ったね！"
    redirect_to timeline_index_path
  end

  private

  def find_post
    @post = TimelinePost.find(params[:timeline_post_id])
  end
end

