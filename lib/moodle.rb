require 'httparty'

class Moodle
  include HTTParty

  def initialize(token, url)
    @token = token
    self.class.base_uri url
  end

  def site_info
    response = self.class.get(
      '/moodle/webservice/rest/server.php',
      {
        :query => {
          :wsfunction => 'core_webservice_get_site_info',
          :moodlewsrestformat => 'json',
          :wstoken => @token
        }
      }
    )
    response.parsed_response
  end
end
