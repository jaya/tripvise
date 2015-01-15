class RecommendationsController < ApplicationController
  before_filter :restrict_access

  def create
    recommendation = Recommendation.new(base_params)
    recommendation.place = Place.find_or_create_by(place_params)

    if recommendation.save
      render json: recommendation, status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  private

  def recommendation_params
    params.require(:recommendation)
  end

  def base_params
    recommendation_params.permit(:description, :rating, :recommender_id, :trip_id)
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
