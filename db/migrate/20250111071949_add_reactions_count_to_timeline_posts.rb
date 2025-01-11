# frozen_string_literal: true

class AddReactionsCountToTimelinePosts < ActiveRecord::Migration[6.1]
  def change
    add_column :timeline_posts, :reactions_count, :integer, default: 0, null: false
  end
end
