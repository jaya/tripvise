require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  describe '#index' do
    before do
      create(:trip, user_id: user.id) if create_trip?
      header(token: user[:fb_token])
      get :index, requester_id: user[:id]
    end

    context 'with exising user' do
      let(:user) { create(:user) }
      let(:create_trip?) { true }

      it 'responds with 200' do
        expect(response).to have_http_status :ok
      end

      it 'returns all trips from requester' do
        expect(json['trips']).to_not be_empty
      end
    end

    context 'without existing user' do
      let(:user) { build(:user, id: 10_000, fb_token: 'ASDAS12312') }
      let(:create_trip?) { false }

      it 'responds with 401' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe '#create' do
    before do
      header(token: user[:fb_token])
      post :create, format: :json, trip: json
    end
    let(:trip) { Trip.first }
    let(:user) { create(:user) }

    context 'with valid data' do
      let(:json) { attributes_for(:trip_json, user_id: user.id) }

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
      let(:json) do
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

      header(token: user[:fb_token])
      get :recommendations, format: :json, id: trip[:id]
    end

    context 'with valid data' do
      let(:user) { create(:user) }
      let(:trip) { create(:trip, user: user) }
      let(:create_recommendation?) { true }

      it 'responds with 200' do
        expect(response).to have_http_status :ok
      end

      describe 'JSON response' do
        it 'has objects' do
          expect(json).to_not be_nil
        end

        it 'has recommendations' do
          expect(json['recommendations'].count).to be > 0
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
