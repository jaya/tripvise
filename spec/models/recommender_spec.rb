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

  describe '#recommend_as' do
    let(:fb_friend) { { 'name' => 'FB Friend', 'id' => '633177910141622' } }
    let(:fb_friends) { [fb_friend] }
    let(:current_user) { create(:user) }
    let(:recommender) { described_class.recommend_as(current_user).first }
    let(:trip) { Trip.joins(:user).where(users: { fb_id: fb_friend['id'] }).first }

    before do
      create(:not_private_trip)
      allow_any_instance_of(Koala::Facebook::API).to \
      receive(:get_connections).and_return(fb_friends)
    end

    it 'assigns the correct user to recommender' do
      expect(recommender.user.id).to eq current_user.id
    end

    it 'assigns the correct trip to recommender' do
      expect(recommender.trip.id).to eq trip.id
    end

    it 'assigns the correct trip code to recommender' do
      expect(recommender.code.id).to eq trip.code.id
    end
  end
end
