require 'rails_helper'

RSpec.describe RecommendationsController, type: :controller do
  describe '#create' do
    before do
      user = User.find_by(id: recommendation[:recommender_id])
      token = ActionController::HttpAuthentication::Token.encode_credentials(user.fb_token)
      request.headers['HTTP_AUTHORIZATION'] = token
      post :create, format: :json, recommendation: recommendation
    end

    context 'with valid data' do
      let(:recommendation) { attributes_for(:recommendation_json) }

      it 'responds with 200' do
        expect(response).to have_http_status :ok
      end

      it 'creates a recommendation' do
        expect do
          post :create, recommendation: attributes_for(:recommendation_json)
        end.to change(Recommendation, :count).by(1)
      end
    end
  end
end
