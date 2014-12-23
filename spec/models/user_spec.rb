require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe '#associations' do
    it { expect(user).to have_many(:trips) }
  end

  context 'when data is invalid' do
    it { expect(build(:user, fb_id: nil)).to validate_presence_of(:fb_id) }
    it { expect(build(:user, fb_token: nil)).to validate_presence_of(:fb_token) }
  end

  context 'when data is valid' do
    it { expect(build(:user)).to be_valid }
  end
end
