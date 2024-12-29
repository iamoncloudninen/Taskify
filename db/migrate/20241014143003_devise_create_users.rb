# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_users_table
    add_user_indexes
  end

  private

  def create_users_table
    create_table :users do |t|
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.string :username
      t.string :profile_image_id
      t.timestamps null: false
    end
  end

  def add_user_indexes
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
