require 'rails_helper'

RSpec.describe User, :type => :model do
  context 'when data is invalid' do
    it { expect(build(:user, fb_id: nil)).to_not be_valid }
    it { expect(build(:user, fb_token: nil)).to_not be_valid }

    describe '#email' do
      it { expect(build(:user, email: nil)).to_not be_valid }

      it 'is invalid with duplicates' do
        create(:user)
        user = build(:user)

        user.valid?
        expect(user.errors[:email]).to include 'has already been taken'
      end
    end
  end

  context 'when data is valid' do
    it { expect(build(:user)).to be_valid }
  end
end
