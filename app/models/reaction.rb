class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :timeline_post
end
