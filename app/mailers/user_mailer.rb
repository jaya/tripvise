class UserMailer < ActionMailer::Base
  default from: 'notify@tripvise.com'

  def recommendations(sender, users, trip)
    users.each do |user|
      recommend(sender, user, trip)
    end
  end

  private

  def recommend(sender, user, trip)
    @sender = sender
    @user = user
    @trip = trip
    mail to: @user.email, subject: "#{@sender.name} wants your recommendation!"
  end
end
