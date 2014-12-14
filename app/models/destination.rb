class Destination < ActiveRecord::Base
  has_many :trips
  validates_presence_of :city, :state, :country, :full_qualified_name
end
