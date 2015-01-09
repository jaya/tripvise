class User < ActiveRecord::Base
  has_many :trips
  has_many :recommendations
  has_one :recommender

  validates_presence_of :name, :email, :fb_id, :fb_token
end
