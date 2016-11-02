require 'active_record'

AVERAGE_WPM = 150

class Post < ActiveRecord::Base
  # Validation constraints
  validates :title, 
    length: { minimum: 1, maximum: 400 }
  validates :content,
    length: { minimum: 1 }
  validates :user_id,
    presence: true

  # Associations
  belongs_to :user
  has_many :comments

  # Return estimated reading time for post content
  def estimated_reading_time
    estimate = content.split(/\s+/).length / AVERAGE_WPM
    "#{estimate >= 1 ? estimate : '< 1'} min read"
  end
end
