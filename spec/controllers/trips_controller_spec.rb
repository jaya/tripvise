require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  describe '#index' do
    before do
      user = User.find_by(id: user_id)
      request.headers['Authorization'] = user ? user.fb_token : user
      get :index, requester_id: user_id
    end
    let(:trip_json) { JSON.parse(response.body) }
    let(:user) { create(:user) }

    context 'with exising user' do
      let(:user_id) do
        trip = create(:trip, user_id: user.id)
        trip.user_id
      end

      it 'responds with 200' do
        expect(response).to have_http_status :ok
      end

      it 'returns all trips from requester' do
        expect(trip_json['trips']).to_not be_empty
      end
    end

    context 'without existing user' do
      let(:user_id) do
        trip = create(:trip, user_id: 10_000)
        trip.user_id
      end

      it 'responds with 401' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe '#create' do
    before do
      user = User.find_by(id: trip_json[:user_id])
      request.headers['Authorization'] = user ? user.fb_token : user
      post :create, format: :json, trip: trip_json
    end
    let(:trip) { Trip.first }
    let(:user) { create(:user, email: 'jose@gmail.com') }

    context 'with valid data' do
      let(:trip_json) { attributes_for(:trip_json, user_id: user.id) }

      it 'responds with 200' do
        expect(response).to have_http_status :ok
      end

      it 'creates a trip' do
        expect do
          post :create, trip: attributes_for(:trip_json)
        end.to change(Trip, :count).by(1)
      end

      it 'has a picture for the location' do
        expect do
          trip.destination.picture.to_not be_nil
        end
      end
    end

    context 'with invalid data' do
      let(:trip_json) do
        attributes_for(:invalid_trip, destination: attributes_for(:destination),
                                      recommendation_type: attributes_for(:recommendation_type))
      end

      it 'responds with 401' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
