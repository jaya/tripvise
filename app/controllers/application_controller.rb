require 'mandrill'

class ApplicationController < ActionController::API
  include ActionController::Serialization
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_filter :verify_authorization_token

  rescue_from ActionController::ParameterMissing do
    render nothing: true, status: 400
  end

  rescue_from ActiveRecord::RecordInvalid do
    render nothing: true, status: :bad_request
  end

  def initialize
    @mandrill = Mandrill::API.new('F9SrPQdt9N24Dy_2lmUd8A')
  end

  def authorization_token
    request.headers['HTTP_AUTHORIZATION']
  end

  def verify_authorization_token
    unauthorized_access if authorization_token.blank?
  end

  def unauthorized_access
    render nothing: true, status: :unauthorized
  end

  def bad_request
    render nothing: true, status: :bad_request
  end
end
