class User < ActiveRecord::Base
  has_many :trips
  validates_presence_of :name, :email, :fb_id, :fb_token
  validates_uniqueness_of :email
end
