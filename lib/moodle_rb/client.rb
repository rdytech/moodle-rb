module MoodleRb
  class Client
    include HTTParty
    include Utility

    attr_reader :token, :url, :query_options

    def initialize(token, url, query_options)
      @token = token
      @url = url
      @query_options = query_options
      self.class.base_uri url
    end

    def site_info
      response = self.class.get(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_webservice_get_site_info', token)
        }.merge(query_options)
      )
      check_for_errors(response)
      response.parsed_response
    end

    def courses
      MoodleRb::Courses.new(token, url, query_options)
    end

    def categories
      MoodleRb::Categories.new(token, url, query_options)
    end

    def users
      MoodleRb::Users.new(token, url, query_options)
    end

    def enrolments
      MoodleRb::Enrolments.new(token, url, query_options)
    end

    def grades
      MoodleRb::Grades.new(token, url, query_options)
    end
  end
end
