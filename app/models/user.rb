class User < ActiveRecord::Base
  has_and_belongs_to_many :trips
  validates_presence_of :name, :email, :fb_id, :fb_token
  validates_uniqueness_of :email
end
