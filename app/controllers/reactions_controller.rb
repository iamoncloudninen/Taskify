class ReactionsController < ApplicationController
  before_action :set_post

  def create
    @post.reactions.create(user: current_user)
    redirect_back fallback_location: root_path, notice: "頑張ったね！"
  end

  private

  def set_post
    @post = TimelinePost.find(params[:timeline_post_id])
  end
end
