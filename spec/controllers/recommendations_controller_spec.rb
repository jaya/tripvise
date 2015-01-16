require 'rails_helper'

RSpec.describe RecommendationsController, type: :controller do
  describe '#create' do
    before do
      token = 'Token token=' + user[:fb_token]
      request.headers['Authorization'] = token
      post :create, format: :json, recommendation: recommendation
    end
    let(:json_response) { JSON.parse(response.body) }

    context 'with valid data' do
      let(:user) { create(:user) }
      let(:recommendation) { attributes_for(:recommendation_json) }

      it 'responds with 204' do
        expect(response).to have_http_status :no_content
      end

      it 'creates a recommendation' do
        expect do
          post :create, recommendation: recommendation
        end.to change(Recommendation, :count).by(1)
      end
    end

    context 'with invalid data' do
      let(:user) { User.new(id: 123, fb_token: '123123A') }
      let(:recommendation) { attributes_for(:recommendation_json) }

      it 'responds with 401' do
        expect(response).to have_http_status :unauthorized
      end

      it 'doens\'t create a user' do
        expect(Recommendation.all).to be_empty
      end
    end
  end
end
