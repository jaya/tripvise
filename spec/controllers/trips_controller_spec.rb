require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  describe '#index' do
    before do
      get :index, requester_id: user_id
    end
    let(:trip_json) { JSON.parse(response.body) }

    context 'with params' do
      let(:user_id) do
        trip = create(:trip, user_id: create(:user).id)
        trip.user_id
      end

      it 'responds with 200' do
        expect(response).to have_http_status :ok
      end

      it 'returns all trips from requester' do
        expect(trip_json['trips']).to_not be_empty
      end
    end

    context 'without params' do
      let(:user_id) do
        trip = create(:trip, user_id: 10_000)
        trip.user_id
      end

      it 'responds with 400' do
        expect(response).to have_http_status :bad_request
      end
    end
  end

  describe '#create' do
    before do
      post :create, format: :json, trip: trip
    end

    context 'with valid data' do
      let(:trip) { attributes_for(:trip_json) }

      it 'responds with 200' do
        expect(response).to have_http_status :ok
      end

      it 'creates a trip' do
        expect do
          post :create, trip: attributes_for(:trip_json)
        end.to change(Trip, :count).by(1)
      end
    end

    context 'with invalid data' do
      let(:trip) { attributes_for(:invalid_trip, destination: attributes_for(:destination)) }

      it 'responds with 400' do
        expect(response).to have_http_status :bad_request
      end
    end
  end
end
