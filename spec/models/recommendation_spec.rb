require 'rails_helper'

RSpec.describe Recommendation, type: :model do
  let(:recommendation) { build(:recommendation) }

  describe '#associations' do
    it { expect(recommendation).to belong_to(:recommender) }
    it { expect(recommendation).to belong_to(:place) }
    it { expect(recommendation).to belong_to(:trip) }
  end

  context 'with valid data' do
    it { expect(recommendation).to be_valid }
  end

  context 'with invalid data' do
    it { expect(build(:recommendation, description: nil)).to validate_presence_of(:description) }
    it { expect(build(:recommendation, place_type: nil)).to validate_presence_of(:place_type) }
  end
end
