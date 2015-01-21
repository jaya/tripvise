class RecommendationSerializer < ActiveModel::Serializer
  attributes :id, :place, :description, :wishlisted, :rating

  has_one :trip
  has_one :recommender, root: :user
end
