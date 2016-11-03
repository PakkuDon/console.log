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
  has_many :followers,
    through: :follower_follows,
    source: :follower
  has_many :follower_follows,
    foreign_key: :followee_id,
    class_name: "Follow"
  has_many :followees,
    through: :followee_follows,
    source: :followee
  has_many :followee_follows,
    foreign_key: :follower_id,
    class_name: "Follow"

  has_secure_password
end
