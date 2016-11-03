require 'active_record'

class User < ActiveRecord::Base
  # Validation constraints
  validates :username,
    uniqueness: true,
    length: { minimum: 4, maximum: 400 }
  validates :email,
    uniqueness: true,
    length: { minimum: 4, maximum: 400 }

  # Associations
  has_many :posts
  has_many :likes
  
  has_secure_password
end
