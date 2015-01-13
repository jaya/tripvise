class RecommenderSerializer < ActiveModel::Serializer
  attributes :recommendations

  has_one :trip
  has_one :user

  def recommendations
    Recommendation.where(trip: object.trip).where(recommender: object.user)
  end
end
