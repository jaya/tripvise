require 'rails_helper'

RSpec.describe Recommender, type: :model do
  let(:recommender) { build(:recommender) }

  context '#associations' do
    it { expect(recommender).to belong_to(:user) }
    it { expect(recommender).to belong_to(:trip) }
    it { expect(recommender).to belong_to(:code) }
  end

  context 'with valid data' do
    it { expect(recommender).to be_valid }
  end

  context 'with invalid data' do
    it { expect(build(:recommender, trip_id: nil)).to validate_presence_of(:trip_id) }
    it { expect(build(:recommender, user_id: nil)).to validate_presence_of(:user_id) }
    it { expect(build(:recommender, code_id: nil)).to validate_presence_of(:code_id) }
  end
end
