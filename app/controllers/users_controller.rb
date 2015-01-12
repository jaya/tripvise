class UsersController < ApplicationController
  before_action :set_params, only: [:send_email, :redeem]

  before_filter :restrict_access, except: [:create]

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

    UserMailer.recommendations(@user, users, @trip).deliver

    no_content
  end

  def redeem
    recommender = Recommender.new(code: @code,
                                  trip: @trip,
                                  user: @user)

    recommender.save ? success : bad_request
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :fb_id, :fb_token, :profile_picture)
  end

  def set_params
    @user = User.find_by(id: params[:id])
    @code = Code.find_by(code: params[:trip_code])

    return bad_request unless @user && @code

    @trip = @code.trip
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, _options|
      User.exists?(fb_token: token)
    end
  end
end
