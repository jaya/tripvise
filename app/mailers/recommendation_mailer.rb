class RecommendationMailer < ActionMailer::Base
  default from: 'tripvise.me@tripvise.me'

  def notify(sender, user, trip)
    @sender = sender
    @user = user
    @trip = trip
    mail to: @user.email, subject: "#{@sender.name} made a recommendation for you!"
  end
end
