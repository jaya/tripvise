class TripsController < ApplicationController
  def create
    trip = Trip.new(trip_params)

    if trip.save
      render json: trip, status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:start, :end, :destination_id)
  end
end
