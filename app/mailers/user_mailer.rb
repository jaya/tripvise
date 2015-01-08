class UserMailer < ActionMailer::Base
  default from: 'notify@tripvise.com'

  def recommendations(sender, users, trip_code)
    users.each do |user|
      recommend(sender, user, trip_code)
    end
  end

  private

  def recommend(sender, user, trip_code)
    @sender = sender
    @user = user
    @trip_code = trip_code
    mail to: @user.email, subject: "#{@sender.name} wants your recommendation!"
  end
end
