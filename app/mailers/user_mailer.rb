class UserMailer < ActionMailer::Base
  default from: 'notifications@tripvise.me'

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
    @code = Code.find_by(trip_id: @trip.id)
    mail to: @user.email, subject: "#{@sender.name} wants your recommendation!"
  end
end
