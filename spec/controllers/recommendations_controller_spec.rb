require 'rails_helper'

RSpec.describe RecommendationsController, type: :controller do
  describe '#create' do
    before do
      header(user[:fb_token])
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

      it 'doens\'t create a recommendation' do
        expect(Recommendation.all).to be_empty
      end
    end
  end

  describe '#wishlist' do
    before do
      header(user[:fb_token])
      post :wishlist, format: :json, id: recommendation[:id]
    end

    context 'with valid data' do
      let(:user) { create(:user) }

      context 'when recommendation is not wishlisted' do
        let(:recommendation) { create(:recommendation) }

        it 'responds with 204' do
          expect(response).to have_http_status :no_content
        end

        it 'flags the recommendation as wishlisted' do
          expect(recommendation.wishlisted).to be_truthy
        end
      end

      context 'when recommendation is wishlisted' do
        let(:recommendation) { create(:recommendation, wishlisted: true) }

        it 'responds with 204' do
          expect(response).to have_http_status :no_content
        end

        it 'flags the recommendation as not wishlisted' do
          expect(Recommendation.find_by(id: recommendation[:id])
                .wishlisted).to be_falsey
        end
      end
    end

    context 'with invalid data' do
      context 'when user is invalid' do
        let(:user) { build(:user, id: 123, fb_token: '123123A') }
        let(:recommendation) { attributes_for(:recommendation_json) }

        it 'responds with 401' do
          expect(response).to have_http_status :unauthorized
        end
      end

      context 'when recommendation doesn\'t exist' do
        let(:user) { create(:user) }
        let(:recommendation) { build(:recommendation, id: 10_000) }

        it 'responds with 400' do
          expect(response).to have_http_status :bad_request
        end
      end
    end
  end
end
