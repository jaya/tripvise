class RecommenderSerializer < ActiveModel::Serializer
  attributes :recommendations, :user

  has_one :trip

  def user
    object.trip.user
  end

  def recommendations
    Recommendation.where(trip: object.trip, recommender: object.user)
  end
end
