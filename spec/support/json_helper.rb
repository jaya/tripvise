module JSONHelper
  def json
    @json ||= JSON.parse(response.body)
  end
end
