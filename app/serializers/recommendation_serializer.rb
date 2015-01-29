class RecommendationSerializer < ActiveModel::Serializer
  attributes :id, :description, :wishlisted, :rating, :expedia_url,
             :tripadvisor_url, :recommendation_type

  has_one :place
  has_one :trip
  has_one :recommender, root: :user

  def expedia_url
    'www.expedia.com'
  end

  def tripadvisor_url
    'www.tripadvisor.com'
  end

  def recommendation_type
    object.trip.recommendation_type
  end
end
