class Place < ActiveRecord::Base
  has_many :recommendations
end
