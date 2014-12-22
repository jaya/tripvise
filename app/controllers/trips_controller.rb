class TripsController < ApplicationController
  def index
    user = User.find_by(id: requester_params)

    if user
      render json: Trip.where(user_id: user.id), status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  def create
    trip = Trip.new(base_params)
    trip.destination = Destination.find_or_create_by(destination_params)
    trip.recommendation_type = RecommendationType.find_or_create_by(recommendation_params)

    if trip.save
      render json: trip, status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  private

  def trip_params
    params.require(:trip)
  end

  def base_params
    trip_params.permit(:start, :end, :user_id)
  end

  def destination_params
    trip_params.require(:destination).permit(:city, :state, :country, :full_qualified_name)
  end

  def recommendation_params
    trip_params.require(:recommendation_type).permit(:hotels, :attractions, :restaurants)
  end

  def requester_params
    params.permit(:requester_id)['requester_id']
  end
end
