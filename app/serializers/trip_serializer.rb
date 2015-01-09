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
    0
  end

  def recommendation_count
    0
  end

  def created_at
    time_ago_in_words(object.created_at)
  end
end
