require 'rails_helper'

RSpec.describe RecommendationMailer, type: :mailer do
  before do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @sender = create(:user_recommender)
    @user = create(:user)
    @recommendation = create(:recommendation, recommender: @sender)
    @trip = create(:trip)
    RecommendationMailer.notify(@sender, @user, @trip).deliver
  end

  it 'should send an email' do
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  it 'renders the receiver email' do
    expect(ActionMailer::Base.deliveries.first).to_not be_nil
  end

  it 'sets the subject to the correct subject' do
    expect(ActionMailer::Base.deliveries.first.subject).to eq('Will Smith ' \
                                                              'made a recommendation for you!')
  end

  it 'renders the sender email' do
    expect(ActionMailer::Base.deliveries.first.from).to eq(['notifications@tripvise.me'])
  end
end
