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

  describe '#create_recommenders_for_fb_friends_of' do
    before do
      allow_any_instance_of(Koala::Facebook::API).to \
      receive(:get_connections).and_return(fb_friends)
      @trip = create(:not_private_trip)
      @current_user = create(:user)
    end
    let(:fb_user) { { 'name' => 'FB Friend', 'id' => '633177910141622' } }
    let(:fb_friends) { [fb_user] }

    it 'creates a recommender to the Facebook friend' do
      recommender = described_class.create_recommenders_for_fb_friends_of(@current_user).first
      expect(recommender.user.id).to eq @current_user.id
      expect(recommender.trip.id).to eq @trip.id
      expect(recommender.code.id).to eq @trip.code.id
    end
  end
end
