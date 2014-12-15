class RecommendationSerializer < ActiveModel::Serializer
  attributes :id, :recommender_id, :place_id, :trip_id, :description, :wishlisted, :rating
end
