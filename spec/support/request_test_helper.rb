module RequestTestHelper
  def header(*args)
    options = args.extract_options!
    token = 'Token token=' + options[:token]
    controller.request.headers['Authorization'] = token
  end
end
