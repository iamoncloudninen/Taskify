# frozen_string_literal: true

class CreateTimelinePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :timeline_posts do |t|
      t.text :content
      t.references :task, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
