# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :content
      t.datetime :deadline
      t.boolean :priority
      t.boolean :status
      t.string :image_id

      t.timestamps
    end
  end
end
