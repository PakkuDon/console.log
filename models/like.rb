require 'active_record'

class Like < ActiveRecord::Base
  # Validation constraints

  # Associations
  belongs_to :post
  belongs_to :user
end
