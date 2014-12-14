class TripsController < ApplicationController
  def create
    trip = Trip.new(base_params)
    trip.destination = Destination.create(destination_params)

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
    trip_params.permit(:start, :end)
  end

  def destination_params
    trip_params.require(:destination).permit(:city, :state, :country, :full_qualified_name)
  end
end
