require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#create' do
    before do
      request.headers['Authorization'] = user[:fb_token]
      post :create, format: :json, user: user
    end
    let(:json_response) { JSON.parse(response.body) }

    context 'with valid data' do
      let(:user) { attributes_for(:user) }

      it 'responds with 200' do
        expect(response).to have_http_status :ok
      end

      it 'creates a user' do
        expect(User.all).to_not be_empty
      end

      it 'has a profile profile_picture' do
        expect(json_response['user']['profile_picture']).to_not be_nil
      end
    end

    context 'with invalid data' do
      let(:user) { attributes_for(:invalid_user) }

      it 'responds with 401' do
        expect(response).to have_http_status :unauthorized
      end

      it 'doens\'t create a user' do
        expect(User.all).to be_empty
      end
    end

    context 'with duplicated email' do
      let(:user) { attributes_for(:user) }

      it 'responds with 200' do
        expect(response).to have_http_status :ok
      end

      it 'returns user that is already created with that email' do
        duplicated = attributes_for(:duplicated_email)
        post :create, format: :json, user: duplicated

        expect(duplicated[:name]).to eq 'Brad Pitt'
      end
    end
  end

  describe '#send_email' do
    before do
      token = 'Token token=' + user[:fb_token]
      request.headers['Authorization'] = token
      post :send_email, format: :json, id: user[:id],
                        trip_code: trip_code,
                        fb_ids: fb_ids
    end
    let(:json_response) { JSON.parse(response.body) }

    context 'with valid data' do
      let(:user) { create(:user) }
      let(:trip_code) { create(:code).code }
      let(:fb_ids) { [create(:user_recommender).fb_id] }

      it 'responds with 204' do
        expect(response).to have_http_status :no_content
      end
    end

    context 'with invalid data' do
      let(:user) { create(:user) }
      let(:trip_code) { 'INVALID' }
      let(:fb_ids) { nil }

      it 'responds with 400' do
        expect(response).to have_http_status :bad_request
      end
    end
  end

  describe '#redeem' do
    before do
      token = 'Token token=' + user[:fb_token]
      request.headers['Authorization'] = token
      post :redeem, format: :json, id: user[:id],
                    trip_code: trip_code
    end

    context 'with valid data' do
      let(:user) { create(:user) }
      let(:trip_code) { create(:code).code }

      it 'responds with 400' do
        expect(response).to have_http_status :no_content
      end
    end

    context 'with invalid data' do
      let(:user) { create(:user) }
      let(:trip_code) { 'INVALID' }

      it 'responds with 400' do
        expect(response).to have_http_status :bad_request
      end
    end
  end

  describe '#recommendation_requests' do
    before do
      trip = create(:trip, user: create(:user_recommender))
      Recommender.create(
        trip: trip,
        user: user,
        code: Code.find_by(trip: trip)
      )

      token = 'Token token=' + user[:fb_token]
      request.headers['Authorization'] = token
      get :recommendation_requests, format: :json, id: user[:id]
    end
    let(:json_response) { JSON.parse(response.body) }

    context 'with valid data' do
      let(:user) { create(:user) }

      it 'responds with 200' do
        expect(response).to have_http_status :ok
      end

      context 'JSON response' do
        it 'has a list of objects' do
          expect(json_response).to_not be_nil
        end

        it 'has an associated user' do
          expect(json_response['recommendation_requests'].first['user']).to_not be_nil
        end

        it 'has an associated trip' do
          expect(json_response['recommendation_requests'].first['trip']).to_not be_nil
        end
      end
    end

    context 'with invalid data' do
      let(:user) { User.new(id: 123, fb_token: '123123A') }

      it 'responds with 401' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe '#my_recommendations' do
    before do
      create(:recommendation, recommender: user, trip: trip)
      create(:recommendation, recommender: user, trip: trip)

      token = 'Token token=' + user[:fb_token]
      request.headers['Authorization'] = token
      get :my_recommendations, format: :json, id: user[:id],
                               trip_id: trip[:id]
    end
    let(:json_response) { JSON.parse(response.body) }

    context 'with valid data' do
      let(:user) { create(:user) }
      let(:trip) { create(:trip, user: user) }

      it 'responds with 200' do
        expect(response).to have_http_status :ok
      end

      context 'JSON response' do
        it 'has a list of objects' do
          expect(json_response).to_not be_nil
        end

        it 'has recommendations' do
          expect(json_response['recommendations']).to_not be_nil
        end

        it 'belongs to the same trip' do
          json_response['recommendations'].each do |recommendation|
            expect(recommendation['trip_id']).to eq(trip.id)
          end
        end
      end
    end

    context 'with invalid data' do
      let(:user) { User.new(id: 123, fb_token: '123123A') }
      let(:trip) { create(:trip, user: user) }

      it 'responds with 401' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
