class Recommendation < ActiveRecord::Base
  belongs_to :recommender, class_name: 'User', foreign_key: 'recommender_id'
  belongs_to :place
  belongs_to :trip

  validates_presence_of :description, :place_type, :google_places_url
end
