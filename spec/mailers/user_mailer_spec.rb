require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  before do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @sender = create(:user)
    @users = [create(:user_recommender)]
    @trip = create(:trip)
    UserMailer.recommendations(@sender, @users, @trip).deliver
  end

  it 'should send an email' do
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  it 'renders the receiver email' do
    expect(ActionMailer::Base.deliveries.first).to_not be_nil
  end

  it 'sets the subject to the correct subject' do
    expect(ActionMailer::Base.deliveries.first.subject).to eq('Angelina Jolie ' \
                                                              'wants your recommendation!')
  end

  it 'renders the sender email' do
    expect(ActionMailer::Base.deliveries.first.from).to eq(['notifications@tripvise.me'])
  end
end
