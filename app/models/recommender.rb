class Recommender < ActiveRecord::Base
  belongs_to :user
  belongs_to :code
  belongs_to :trip

  validates_presence_of :trip_id, :user_id, :code_id
end
