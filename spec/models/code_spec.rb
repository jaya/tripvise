require 'rails_helper'

RSpec.describe Code, type: :model do
  let(:code) { build(:code) }

  context 'with valid data' do
    it { expect(code).to be_valid }
  end

  context 'with invalid data' do
    it { expect(build(:code, trip_id: nil)).to validate_presence_of(:trip_id) }
  end
end
