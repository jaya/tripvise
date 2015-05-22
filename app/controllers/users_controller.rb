class UsersController < ApplicationController
  before_filter :restrict_access, except: [:create]

  before_action :set_params, only: [:send_email, :redeem]
  before_action :set_user, only: [:recommendation_requests, :my_recommendations]
  before_action :set_trip, only: [:my_recommendations]

  def index
    code = Code.find_by(code: params[:trip_code])

    return bad_request unless code

    render json: code.trip.user, status: :ok
  end

  def create
    user = User.find_or_initialize_by(email: params[:user][:email])

    user.attributes = user_params

    if user.save
      render json: user, status: :ok
    else
      bad_request
    end
  end

  def send_email
    users = User.where(fb_id: params[:fb_ids])

    users.each do |user|
      Recommender.find_or_create_by(user: user, trip: @trip, code: @code)
    end

    UserMailer.recommendations(@user, users, @trip).deliver

    no_content
  end

  def redeem
    recommender = Recommender.new(code: @code,
                                  trip: @trip,
                                  user: @user)

    recommender.save ? no_content : bad_request
  end

  def recommendation_requests
    Recommender.recommend_as(@user)

    recommenders = Recommender.where(user: @user)

    render json: recommenders,
           root: 'recommendation_requests',
           status: :ok
  end

  def my_recommendations
    render json: Recommendation.where(recommender: @user, trip: @trip),
           root: 'recommendations',
           status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :fb_id, :fb_token, :profile_picture)
  end

  def set_params
    set_user
    @code = Code.find_by(code: params[:trip_code])

    return bad_request unless @code

    @trip = @code.trip
  end

  def set_trip
    @trip = Trip.find_by(id: params[:trip_id])

    return bad_request unless @trip
  end

  def set_user
    @user = User.find_by(id: params[:id])

    return bad_request unless @user
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, _options|
      User.exists?(fb_token: token)
    end
  end
end
