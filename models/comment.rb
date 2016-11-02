require 'active_record'

class Comment < ActiveRecord::Base
  # Validation constraints
  validates :content, length: { minimum: 1 }
  validates :user_id, presence: true
  validates :post_id, presence: true

  # Associations
  belongs_to :user
  belongs_to :post
end
