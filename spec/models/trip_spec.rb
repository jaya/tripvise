require 'rails_helper'

RSpec.describe Trip, type: :model do
  let(:trip) { build(:trip, destination: build(:destination)) }

  context 'with valid data' do
    it { expect(trip).to be_valid }
  end

  context 'with invalid data' do
    it { expect(build(:invalid_trip)).to_not be_valid }

    context 'when end date is greater than start date' do
      it { expect(trip.start = '2014-12-20 12:33:28').to_not be_valid }
    end
  end
end
