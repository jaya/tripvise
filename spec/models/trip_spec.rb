require 'rails_helper'

RSpec.describe Trip, type: :model do
  let(:trip) { build(:trip, destination: build(:destination)) }

  describe '#associations' do
    it { expect(trip).to belong_to(:user) }
    it { expect(trip).to belong_to(:destination) }
  end

  context 'with valid data' do
    it { expect(trip).to be_valid }
  end

  context 'with invalid data' do
    it { expect(build(:trip, start: nil)).to validate_presence_of(:start) }
    it { expect(build(:trip, end: nil)).to validate_presence_of(:end) }
    it do
      expect(build(:trip, private?: false)).to \
      validate_inclusion_of(:private?).in_array([true, false])
    end

    context 'when end date is greater than start date' do
      it do
        trip.start = '2014-12-20 12:33:28'
        expect(trip).to_not be_valid
      end
    end
  end
end
