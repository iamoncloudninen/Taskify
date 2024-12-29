# frozen_string_literal: true

class TimelinePost < ApplicationRecord
  has_many :task_timeline_posts, dependent: :destroy
  has_many :tasks, through: :task_timeline_posts
  belongs_to :user
  has_many_attached :images
  has_many :reactions, dependent: :destroy
  validates :content, presence: true
  validate :at_least_one_task_selected
  validate :acceptable_images

  private

  def at_least_one_task_selected
    return unless task_ids.blank? || task_ids.reject(&:blank?).empty?

    errors.add(:task_ids, '少なくとも1つのタスクを選択してください。')
  end

  def acceptable_images
    return unless images.attached?

    images.each do |image|
      unless image.content_type.in?(%w[image/jpeg image/png image/gif])
        errors.add(:images, 'JPEG、PNG、またはGIF形式の画像をアップロードしてください。')
      end
      errors.add(:images, '各画像は5MB以下である必要があります。') if image.byte_size > 5.megabytes
    end
  end
end
