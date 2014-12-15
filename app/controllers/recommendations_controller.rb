class RecommendationsController < ApplicationController
  def create
    recommendation = Recommendation.new(recommendation_params)

    if recommendation.save
      render json: recommendation, status: :ok
    else
      render nothing: true, status: :bad_request
    end

  end
  private

  def recommendation_params
    params.require(:recommendation).permit(:id, :description, :wishlisted, :rating,
                                           :recommender_id, :trip_id, :place_id)
  end
end
