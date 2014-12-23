class UsersController < ApplicationController
  before_filter :restrict_access, except: [:create]

  def create
    user = User.find_or_initialize_by(email: params[:user][:email])

    user.attributes = user_params

    if user.save
      render json: user, status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :fb_id, :fb_token, :profile_picture)
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, _options|
      User.exists?(fb_token: token)
    end
  end
end
