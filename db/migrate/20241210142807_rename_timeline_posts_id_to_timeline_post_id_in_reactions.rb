# frozen_string_literal: true

class RenameTimelinePostsIdToTimelinePostIdInReactions < ActiveRecord::Migration[6.1]
  def change
    rename_column :reactions, :timeline_posts_id, :timeline_post_id
  end
end
