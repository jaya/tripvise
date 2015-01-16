require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  describe '#index' do
    before do
      user = User.find_by(id: user_id)
      fb_token = user ? user.fb_token : nil
      token = ActionController::HttpAuthentication::Token.encode_credentials(fb_token)
      request.headers['HTTP_AUTHORIZATION'] = token
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
      fb_token = user ? user.fb_token : nil
      token = ActionController::HttpAuthentication::Token.encode_credentials(fb_token)
      request.headers['HTTP_AUTHORIZATION'] = token
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

      it 'responds with 400' do
        expect(response).to have_http_status :bad_request
      end
    end
  end

  describe '#recommendations' do
    before do
      create(:recommendation, trip: trip) if create_recommendation?

      token = 'Token token=' + user[:fb_token]
      request.headers['HTTP_AUTHORIZATION'] = token
      get :recommendations, format: :json, id: trip[:id]
    end
    let(:json_response) { JSON.parse(response.body) }

    context 'with valid data' do
      let(:user) { create(:user) }
      let(:trip) { create(:trip, user: user) }
      let(:create_recommendation?) { true }

      it 'responds with 200' do
        expect(response).to have_http_status :ok
      end

      describe 'JSON response' do
        it 'has objects' do
          expect(json_response).to_not be_nil
        end

        it 'has recommendations' do
          expect(json_response['recommendations'].count).to be > 0
        end
      end
    end

    context 'with invalid data' do
      context 'when user is invalid' do
        let(:user) { build(:user, id: 123, fb_token: '123123A') }
        let(:trip) { create(:trip) }
        let(:create_recommendation?) { false }

        it 'responds with 401' do
          expect(response).to have_http_status :unauthorized
        end
      end

      context 'when trip is invalid' do
        let(:user) { create(:user) }
        let(:trip) { build(:trip, id: 10_000, user: user) }
        let(:create_recommendation?) { false }

        it 'responds with 400' do
          expect(response).to have_http_status :bad_request
        end
      end
    end
  end
end
