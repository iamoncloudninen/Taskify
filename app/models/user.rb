# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  has_many :tasks, dependent: :destroy
  has_many :timeline_post, dependent: :destroy
  has_many :reactions, dependent: :destroy
  validates :username, presence: true
  validates :email, presence: true
  validates :password, confirmation: true, if: :password_required?
  def self.guest_user
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.username = 'ゲストユーザー'
    end
  end
  private

  def password_required?
    password.present? || password_confirmation.present?
  end
end
