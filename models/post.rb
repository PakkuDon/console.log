require 'active_record'

AVERAGE_WPM = 150

class Post < ActiveRecord::Base
  belongs_to :user

  # Return estimated reading time for post content
  def estimated_reading_time
    estimate = content.split(/\s+/).length / AVERAGE_WPM
    "#{estimate >= 1 ? estimate : '< 1'} min read"
  end
end
