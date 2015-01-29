class RecommendationSerializer < ActiveModel::Serializer
  attributes :id, :description, :wishlisted, :rating, :expedia_url,
             :tripadvisor_url

  has_one :place
  has_one :trip
  has_one :recommender, root: :user

  def expedia_url
    'www.expedia.com'
  end

  def tripadvisor_url
    'www.tripadvisor.com'
  end
end
