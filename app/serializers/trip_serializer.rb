class TripSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  attributes :id, :start, :end,
             :wishlist_count, :recommendation_count,
             :created_at, :trip_code

  has_one :destination

  def trip_code
    Code.find_by(trip: object).code
  end

  def wishlist_count
    Recommendation.where(trip: object, wishlisted: true).count
  end

  def recommendation_count
    Recommendation.where(trip: object).count
  end

  def created_at
    time_ago_in_words(object.created_at)
  end
end
