# frozen_string_literal: true

class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.string :message

      t.timestamps
    end
  end
end
