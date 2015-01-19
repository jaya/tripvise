module AuthHelper
  def header(token)
    token = 'Token token=' + token
    controller.request.headers['Authorization'] = token
  end
end
