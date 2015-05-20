class Recommender < ActiveRecord::Base
  belongs_to :user
  belongs_to :code
  belongs_to :trip

  validates_presence_of :trip_id, :user_id, :code_id

  def self.create_recommenders_for_fb_friends_of(current_user)
    fb_friends = user_fb_friend(current_user)

    trips = fb_friends.map do |fb_friend|
      Trip.joins(:user).where(users: { fb_id: fb_friend['id'] }, private?: false).load
    end.flatten

    trips.map do |trip|
      Recommender.find_or_create_by(user: current_user, trip: trip, code: trip.code)
    end
  end

  def self.user_fb_friend(current_user)
    Koala::Facebook::API.new(current_user.fb_id).get_connections('me', 'friends')
  end
end
