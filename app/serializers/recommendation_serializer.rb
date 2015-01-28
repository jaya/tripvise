class RecommendationSerializer < ActiveModel::Serializer
  attributes :id, :description, :wishlisted, :rating

  has_one :place
  has_one :trip
  has_one :recommender, root: :user
end
