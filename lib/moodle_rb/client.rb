module MoodleRb
  class Client
    include HTTParty
    include Utility

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
          :query => query_hash('core_webservice_get_site_info', token)
        }
      )
      if error_response?(response)
        raise MoodleError.new(response.parsed_response)
      else
        response.parsed_response
      end
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

    def grades
      MoodleRb::Grades.new(token, url)
    end
  end
end
