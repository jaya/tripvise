require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  describe '#create' do
    before do
      post :create, format: :json, trip: trip
    end

    context 'with valid data' do
      let(:trip) { attributes_for(:trip) }

      it 'responds with 200' do
        expect(response).to have_http_status :ok
      end

      it 'creates a trip' do
        expect do
          post :create, trip: attributes_for(:trip)
        end.to change(Trip, :count).by(1)
      end
    end

    context 'with invalid data' do
      let(:trip) { attributes_for(:invalid_trip) }

      it 'responds with 400' do
        expect(response).to have_http_status :bad_request
      end
    end
  end
end
