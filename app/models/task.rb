class Task < ApplicationRecord
  belongs_to :user
  attachment :image
  has_and_belongs_to_many :timeline_posts
end
