module MoodleRb
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
          :query => Utility.query_hash('core_webservice_get_site_info', token)
        }
      )
      response.parsed_response
    end

    def courses
      MoodleRb::Courses.new(token, url)
    end

    def categories
      MoodleRb::Categories.new(token, url)
    end

    def users
      MoodleRb::Users.new(token, url)
    end

    def enrolments
      MoodleRb::Enrolments.new(token, url)
    end
  end
end
