class LandingPageController < ApplicationController
  skip_before_action :verify_authorization_token

  def index
  end
end
