class RecommendationsController < ApplicationController
  before_filter :restrict_access

  def create
    recommendation = Recommendation.new(base_params)
    recommendation.place = Place.find_or_create_by(place_params)

    if recommendation.save
      send_email

      no_content
    else
      bad_request
    end
  end

  def wishlist
    recommendation = Recommendation.find_by(id: params[:id])

    return bad_request unless recommendation

    recommendation.toggle(:wishlisted)

    recommendation.save ? no_content : bad_request
  end

  private

  def send_email
    trip = Trip.find_by(id: params[:recommendation][:trip_id])
    recommender = User.find_by(id: params[:recommendation][:recommender_id])
    RecommendationMailer.notify(recommender, trip.user, trip).deliver
  end

  def recommendation_params
    params.require(:recommendation)
  end

  def base_params
    recommendation_params.permit(:description, :rating,
                                 :recommender_id, :trip_id,
                                 :place_type, :google_places_url)
  end

  def place_params
    recommendation_params.require(:place).permit(:city, :name)
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, _options|
      User.exists?(fb_token: token)
    end
  end
end
