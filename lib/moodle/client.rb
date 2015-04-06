class Client
  include HTTParty

  attr_reader :token, :url

  def initialize(token, url)
    @token = token
    @url = url
    self.class.base_uri url
  end

  def site_info
    response = self.class.get(
      '/webservice/rest/server.php',
      {
        :query => {
          :wsfunction => 'core_webservice_get_site_info',
          :moodlewsrestformat => 'json',
          :wstoken => token
        }
      }
    )
    response.parsed_response
  end

  def courses
    Courses.new(token, url)
  end
end