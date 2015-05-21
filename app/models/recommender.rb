class Recommender < ActiveRecord::Base
  belongs_to :user
  belongs_to :code
  belongs_to :trip

  validates_presence_of :trip_id, :user_id, :code_id

  def self.recommend_as(current_user)
    fb_friends = facebook_friends_for(current_user)

    trips = fb_friends.map do |fb_friend|
      Trip.joins(:user).where(users: { fb_id: fb_friend['id'] }, private?: false).load
    end.flatten

    trips.map do |trip|
      Recommender.find_or_create_by(user: current_user, trip: trip, code: trip.code)
    end
  end

  def self.facebook_friends_for(current_user)
    Koala::Facebook::API.new(current_user.fb_token).get_connections('me', 'friends')
  end
end
