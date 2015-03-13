class LandingPageController < ApplicationController
  skip_before_action :verify_authorization_token

  def index
  end

  def privacy_policy
    render 'landing_page/privacy_policy'
  end
end
